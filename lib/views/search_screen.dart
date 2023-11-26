import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/fontsize.dart';
import 'package:devfest_hackaton/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      const Icon(Icons.business),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        children: [
                          AppText(
                            "Nom de l'arret en question",
                            isBold: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppText("prochain bus dans 15 min"),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          // ajouter dans la liste des enregistrements
                        },
                        child: const Icon(Icons.schedule),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      const Icon(Icons.business),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        children: [
                          AppText(
                            "Nom de l'arret en question",
                            isBold: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppText("prochain bus dans 15 min"),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          // ajouter dans la liste des enregistrements
                        },
                        child: const Icon(Icons.schedule),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      const Icon(Icons.business),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        children: [
                          AppText(
                            "Nom de l'arret en question",
                            isBold: true,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AppText("prochain bus dans 15 min"),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          // ajouter dans la liste des enregistrements
                        },
                        child: const Icon(Icons.schedule),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                width: double.maxFinite,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.divider,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ],
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Rechercher',
                          hintStyle: TextStyle(
                            fontSize: AppFontSize.medium,
                          ),
                          labelStyle: TextStyle(
                            fontSize: AppFontSize.medium,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.search,
                      size: 20,
                      color: AppColors.primary,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
