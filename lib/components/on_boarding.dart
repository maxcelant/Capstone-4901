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
                color: const Color(0xffBDD4E7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Image(image: AssetImage('assets/trans_logo.png')),
                    Text(
                      "Welcome to Brix Color Finder",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Swipe left to read the instructions on how to use the app, or click on the 'Skip boarding' button to access our cool features",
                      textAlign: TextAlign.center,
                    ),
                    const Text("1/3"),
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
                  style: TextStyle(color: Color(0xff212227)),
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
              ))
        ],
      ),
    );
  }
}
