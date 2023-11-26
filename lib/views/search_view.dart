import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/fontsize.dart';
import 'package:devfest_hackaton/viewmodels/search_viewmodels.dart';
import 'package:devfest_hackaton/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    SearchViewModels searchViewModels = Provider.of(context);

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
                  ...searchViewModels
                      .getFilteredStations()
                      .map(
                        (station) => Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.divider),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(children: [
                                const Icon(
                                  Iconsax.building,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      station.name,
                                      isBold: true,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AppText(
                                        "prochain bus vers ${station.heureArrive}"),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                GestureDetector(
                                  onTap: () {
                                    searchViewModels
                                        .toggleStationNotified(station);
                                  },
                                  child: Icon(
                                    station.isNotified
                                        ? Icons.notifications
                                        : Icons.notifications_none,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                      .toList()
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
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchViewModels.query,
                        onChanged: (newText) {
                          searchViewModels.updateQuery(newText);
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.white,
                          hintText: 'Rechercher votre arrêt ici...',
                          hintStyle: TextStyle(
                            fontSize: AppFontSize.large,
                          ),
                          labelStyle: TextStyle(
                            fontSize: AppFontSize.large,
                          ),
                        ),
                      ),
                    ),
                    const Icon(
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
