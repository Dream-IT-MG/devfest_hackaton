import 'package:flutter/cupertino.dart';

import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
    required RiveAnimationController btnAnimationColtroller,
    required this.press,
  })  : _btnAnimationColtroller = btnAnimationColtroller,
        super(key: key);

  final RiveAnimationController _btnAnimationColtroller;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: press,
          child: SizedBox(
            height: 64,
            width: 260,
            child: Stack(
              children: [
                // Just a button no animation
                // Let's fix that
                RiveAnimation.asset(
                  "assets/animations/button.riv",
                  // Once we restart the app it shows the animation
                  controllers: [_btnAnimationColtroller],
                ),
                const Positioned.fill(
                  // But it's not center
                  top: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.arrow_right),
                      SizedBox(width: 8),
                      Text(
                        "Bougez vous",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
