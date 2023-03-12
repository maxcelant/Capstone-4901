import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_screen.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final controller = PageController();

  void dispose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller,
            children: [
              Container(
                color: const Color.fromARGB(255, 236, 236, 236),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image(
                        image: AssetImage('assets/trans_logo.png'),
                      ),
                    ),
                    const Text(
                      "Welcome to Brix Color Identifier",
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Swipe left to read the instructions on how to use the app",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromARGB(255, 70, 78, 93),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("this app will allow you to identify many lego pieces",
                        style: Theme.of(context).textTheme.headline3),
                    const Text("scroll to the next page"),
                  ],
                ),
              ),
              Container(
                color: const Color(0xffAAB9CF),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "to increase the accuracy follow these instructions, ",
                          style: Theme.of(context).textTheme.headline3),
                      const Text("congratulations"),
                    ]),
              )
            ],
          ),
          Positioned(
            top: 60,
            right: 20,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'BriXColor Finder')));
                },
                child: const Text(
                  "Skip tutorial",
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 37, 40),
                    fontFamily: 'WorkSans',
                  ),
                )),
          ),
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn),
            ),
          )
        ],
      ),
    );
  }
}
