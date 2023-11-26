import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/show_app_modal_bottom_sheet.dart';
import 'package:devfest_hackaton/viewmodels/historique_viewmodels.dart';
import 'package:devfest_hackaton/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoriqueView extends StatelessWidget {
  const HistoriqueView({super.key});

  @override
  Widget build(BuildContext context) {
    HistoriqueViewModels historiqueViewModels = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ...historiqueViewModels.trajetListe.map(
                  (trajet) => TimelineTile(
                    isFirst: trajet == historiqueViewModels.trajetListe.first,
                    isLast: trajet == historiqueViewModels.trajetListe.last,
                    beforeLineStyle: const LineStyle(
                      color: AppColors.secondary,
                    ),
                    indicatorStyle: IndicatorStyle(
                      width: 30,
                      color: AppColors.primary,
                      iconStyle: IconStyle(
                        iconData: Icons.bus_alert,
                        color: Colors.white,
                      ),
                    ),
                    endChild: Container(
                      margin: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Iconsax.global,
                                    size: 20,
                                    color: AppColors.textColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  AppText(
                                    "${trajet.depart} - ${trajet.arrive}\n(${trajet.fees})",
                                    isBold: true,
                                    color: AppColors.textColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: IconButton(
                                  onPressed: () {
                                    // showAppModalBottomSheet(ctx);
                                    // ...
                                  },
                                  color: AppColors.primary,
                                  icon: const Icon(Iconsax.more),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
