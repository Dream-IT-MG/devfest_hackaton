import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget desktopScaffold;

  const ResponsiveLayout({
    Key? key,
    required this.mobileScaffold,
    required this.desktopScaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildLayout(constraints.maxWidth);
      },
    );
  }

  Widget _buildLayout(double maxWidth) {
    return maxWidth < 1100 ? mobileScaffold : desktopScaffold;
  }
}
