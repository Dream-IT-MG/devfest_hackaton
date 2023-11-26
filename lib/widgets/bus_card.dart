import 'package:flutter/material.dart';

class BusCard extends StatelessWidget {
  const BusCard(
      {super.key,
      this.isSelected = false,
      required this.name,
      required this.i,
      required this.heureArrivee,
      required this.prochaineArrivee,
      required this.onSelect,
      required this.id});

  final bool isSelected;
  final String name;
  final String heureArrivee;
  final String prochaineArrivee;
  final String id;
  final int i;
  final void Function(int id) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: Colors.white) : null,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 3))
        ],
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () => onSelect(i),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12)),
                  width: 80,
                  height: double.maxFinite,
                  child: Center(
                    child: Text(
                      id,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        prochaineArrivee,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        heureArrivee,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: isSelected
                  ? const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.blue,
                      ))
                  : const SizedBox(),
            ),
          )
        ],
      ),
    );
  }
}
