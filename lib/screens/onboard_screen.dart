import 'package:cheeky_chewer/components/onboarding_widget.dart';
import 'package:cheeky_chewer/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utilities/constants.dart';

class OnboardScreen extends StatefulWidget {
  static String id = 'onboardscreen';
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: pageIndex == 2
            ? AppBar(
                backgroundColor: Colors.white12,
                elevation: 0.0,
              )
            : AppBar(
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('seen', true);
                        Navigator.pushReplacementNamed(context, Register.id);
                      },
                      child: Text(
                        'skip',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
                backgroundColor: Colors.white12,
                elevation: 0.0,
              ),
        body: Container(
          padding: EdgeInsets.only(bottom: 100),
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [
              Onboarding(
                imageName: 'images/create.png',
                title: 'Create recipe',
                description:
                    'Layout your steps for making your favourite, mouth watering meals',
              ),
              Onboarding(
                imageName: 'images/share.png',
                title: 'Share recipe',
                description:
                    'Help others make your amazing dishes by sharing your recipes',
              ),
              Onboarding(
                imageName: 'images/fun.png',
                title: 'Have fun',
                description:
                    'Like, review and discuss your recipes with the cheeky chewer community',
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: KAppColorTheme,
          height: 100,
          child: Center(
            child: Column(
              children: [
                pageIndex == 2
                    ? Expanded(
                        flex: 2,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xffF6AB36),
                            ),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('seen', true);
                            Navigator.pushReplacementNamed(
                                context, Register.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Get Started',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 2,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xffF6AB36),
                            ),
                          ),
                          onPressed: () {
                            pageController.nextPage(
                                duration: Duration(microseconds: 100),
                                curve: Curves.ease);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                Expanded(child: SizedBox()),
                Expanded(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Color(0xffF6AB36),
                      dotColor: Colors.white,
                      dotHeight: 5,
                      dotWidth: 5,
                      expansionFactor: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
