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
                      "Welcome to Lego ID",
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Swipe left to read the instructions on how to use the app, or click on the 'Skip boarding' button to access our cool features",
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
                color: const Color(0xff8693AB),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        "The aim of the application is really straight forward! Place your lego object on a not so colorful surface at least 7 inches away and take a photo",
                        style: Theme.of(context).textTheme.displaySmall),
                    const Text("2/3"),
                  ],
                ),
              ),
              Container(
                color: const Color(0xffAAB9CF),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "Once youve taken your photo our intelligent algorith will help identify the type of Lego brick it is and the color",
                          style: Theme.of(context).textTheme.displaySmall),
                      const Text("3/3"),
                    ]),
              )
            ],
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const MyHomePage(title: 'BriXColor Finder')));
                },
                child: const Text(
                  "Skip boarding",
                  style: TextStyle(
                    color: Color(0xff212227),
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
