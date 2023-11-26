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
  List<String> third_title = [
    "Humain\nintelligent",
    "Humain\naccomplie",
    "Humain\nqui sait ce qu'il fait dans la vie.",
  ];
  int selected_title = 0;

  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    startAnimation();
    Timer.periodic(Duration(seconds: (1 * 3) + 2), (timer) {
      startAnimation();
    });
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (selected_title < 2) {
        setState(() {
          selected_title += 1;
        });
      } else {
        setState(() {
          selected_title = 0;
        });
      }
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
    //  final fb = FirebaseDatabase.instanoce;
    // final ref = fb.ref();
    // // ref.child("Name").set("fooo");
    // ref.child("Name").once().then((DatabaseEvent value) {
    //   print(value.snapshot.value);
    // });

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              Container(
                color: const Color.fromRGBO(195, 72, 84, 1),
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: RiveAnimation.asset(
                            "assets/animations/variation.riv",
                            onInit: (artboard) {
                              controller2 = StateMachineController.fromArtboard(
                                artboard,
                                "State Machine 1",
                              );
                              if (controller2 != null) {
                                artboard.addController(controller2!);
                                inputValue2 = controller2?.findInput("break");
                                inputValue2?.change(false);
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
                      title: "Fixez vos objectifs et suivez vos progrès",
                      description:
                          "Définis tes objectifs, partage tes progrès et sois fière de ce que tu as accompli.",
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color.fromRGBO(70, 46, 84, 1),
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: const RiveAnimation.asset(
                                "assets/animations/rocket.riv",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SlideText(
                      title_size: 40,
                      title: "${third_title[selected_title]}",
                      description:
                          "Découvre qui tu es et choisi parmi les +100 formations à découvrir selon ta personnalité et ton choix de carriere.",
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: AppColors.primary,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: RiveAnimation.asset(
                                // "assets/animations/age.riv",
                                "assets/animations/mixing_animations.riv",
                                onInit: (artboard) {
                                  controller1 =
                                      StateMachineController.fromArtboard(
                                    artboard,
                                    "State Machine 1",
                                    // "AgeClasses",
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
                            Container(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    color: AppColors.primary,
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
                    title: "Apprenez et grandissez",
                    description:
                        "Deviens une meilleure personne grâce à nos quiz et nos petits messages",
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
                                    "Learn design & code",
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontFamily: "Poppins",
                                      height: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
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
                                "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
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
              count: 4,
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
