import 'package:flutter/material.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(
      {super.key,
      this.isSelected = false,
      required this.name,
      required this.heureOuverture,
      required this.dateOuverture,
      required this.contact,
      required this.image,
      required this.longlat,
      required this.id,
      required this.onSelect});

  final bool isSelected;
  final String name;
  final String heureOuverture;
  final String dateOuverture;
  final String contact;
  final dynamic image;
  final String longlat;
  final int id;
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
            onTap: () => onSelect(id),
            child: Row(children: [
              Container(
                alignment: Alignment.center,
                color: Colors.blueGrey,
                width: 50,
                height: double.maxFinite,
                child: Center(
                  child: Text(
                    image,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                        dateOuverture,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        heureOuverture,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            contact,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
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
