import 'dart:async';
import 'dart:ui';

import 'package:devfest_hackaton/entry_point.dart';
import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/responsive_layout.dart';
import 'package:devfest_hackaton/widgets/animated_btn.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rive/rive.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationColtroller;
  PageController _controller = PageController();
  StateMachineController? controller1;
  SMIInput<double>? inputValue1;
  StateMachineController? controller2;
  SMIInput<bool>? inputValue2;
  SMITrigger? _bump;

  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    startAnimation();
    Timer.periodic(Duration(seconds: (1 * 3) + 2), (timer) {
      startAnimation();
    });
    super.initState();
  }

  Future<void> startAnimation() async {
    double i = 0;
    int transition = 1;
    // while (i < 3) {
    Future.delayed(Duration(seconds: 0), () {
      // code to be executed after 2 seconds
      inputValue1?.change(i);
      i++;
    }).then(
      (value) => Future.delayed(Duration(seconds: transition), () {
        // code to be executed after 2 seconds
        inputValue1?.change(i);
        i++;
      }).then(
        (value) => Future.delayed(
          Duration(seconds: transition),
          () {
            // code to be executed after 2 seconds
            inputValue1?.change(2);
            i++;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Container(
                color: const Color(0xff2ed2b6),
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: RiveAnimation.asset(
                            "assets/animations/switch-it-up.riv",
                            onInit: (artboard) {
                              controller2 = StateMachineController.fromArtboard(
                                artboard,
                                "Juicy",
                              );
                              if (controller2 != null) {
                                artboard.addController(controller2!);
                                _bump = controller2!.findInput<bool>('Orange')
                                    as SMITrigger;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    const SlideText(
                      title: "Controllez votre temps",
                      description:
                          "Ne vous prennez plus la tête à courrir après le bus.",
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: AppColors.secondary,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: RiveAnimation.asset(
                                "assets/animations/mixing_animations.riv",
                                onInit: (artboard) {
                                  controller1 =
                                      StateMachineController.fromArtboard(
                                    artboard,
                                    "State Machine 1",
                                  );
                                  if (controller1 != null) {
                                    artboard.addController(controller1!);
                                    inputValue1 =
                                        controller1?.findInput("level");
                                    inputValue1?.change(0);
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    color: AppColors.secondary,
                                    height: 50,
                                    width: double.maxFinite,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SlideText(
                    title: "Facilitez vos déplacement",
                    description:
                        "Petit ou grand, déplacez-vous librement vers votre déstination ",
                  ),
                ],
              ),
              Stack(
                children: [
                  Positioned(
                    width: MediaQuery.of(context).size.width * 1.7,
                    bottom: 200,
                    left: 100,
                    child: Image.asset("assets/images/Spline.png"),
                  ),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
                    ),
                  ),
                  const RiveAnimation.asset("assets/animations/shapes.riv"),
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: const SizedBox(),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 240),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            const SizedBox(
                              width: 260,
                              child: Column(
                                children: [
                                  Text(
                                    "BUS-NAY",
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontFamily: "Poppins",
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Trouvez facilement vos moyens de transport à travers notre application. Enregistrez vos iténeraire pour plus tards.",
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(flex: 2),
                            AnimatedBtn(
                              btnAnimationColtroller: _btnAnimationColtroller,
                              press: () {
                                _btnAnimationColtroller.isActive = true;
                                Future.delayed(
                                  const Duration(milliseconds: 800),
                                  () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const EntryPoint(),
                                            type: PageTransitionType.fade));
                                  },
                                );
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.95),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.white54,
                activeDotColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideText extends StatelessWidget {
  const SlideText({
    super.key,
    required this.title,
    required this.description,
    this.title_size = 40,
  });

  final String title;
  final String description;
  final double title_size;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 100,
      ),
      child: ResponsiveLayout(
        mobileScaffold: Column(
          children: [
            Container(
              width: double.maxFinite,
              child: Text(
                textAlign: TextAlign.start,
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: title_size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
        desktopScaffold: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: double.maxFinite,
                  child: Text(
                    textAlign: TextAlign.start,
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: title_size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
