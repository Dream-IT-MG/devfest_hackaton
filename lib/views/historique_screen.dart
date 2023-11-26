import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/show_app_modal_bottom_sheet.dart';
import 'package:devfest_hackaton/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoriqueScreen extends StatelessWidget {
  const HistoriqueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TimelineTile(
              isFirst: true,
              isLast: false,
              beforeLineStyle: const LineStyle(
                color: AppColors.darkSecondary,
              ),
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: AppColors.divider,
                iconStyle: IconStyle(
                  iconData:
                      true ? Icons.rocket_launch : Icons.star_rate_rounded,
                  color: Colors.white,
                ),
              ),
              endChild: true
                  ? Container(
                      margin: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    // Iconsax.lock,
                                    Iconsax.global,
                                    size: 20,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  AppText(
                                    "Foooo",
                                    isBold: true,
                                    color: AppColors.primary,
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
                                  },
                                  color: AppColors.primary,
                                  icon: const Icon(Iconsax.more),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Iconsax.calendar_1,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              AppText(
                                "18 Jun 2023",
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        color: Colors.white,
                                        // image: DecorationImage(
                                        //   fit: BoxFit.cover,
                                        //   // image: (widget.image is String)
                                        //   //     ? AssetImage(
                                        //   //             "assets/images/${widget.image}")
                                        //   //         as ImageProvider
                                        //   //     : FileImage(widget.image),
                                        // ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Center(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              // Iconsax.lock,
                                              Iconsax.global,
                                              size: 20,
                                              color: AppColors.primary,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            AppText(
                                              "Fooo",
                                              isBold: true,
                                              color: AppColors.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: IconButton(
                                        onPressed: () {
                                          // showModalPopup(context, widget.event);
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
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
