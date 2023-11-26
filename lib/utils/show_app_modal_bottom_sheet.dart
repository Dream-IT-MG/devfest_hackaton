import 'dart:ui';

import 'package:devfest_hackaton/utils/colors.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAppModalBottomSheet({
  required BuildContext context,
  Widget? child,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: AppColors.white.withOpacity(0.7),
        ),
        child: child,
      ),
    ),
  );
}
