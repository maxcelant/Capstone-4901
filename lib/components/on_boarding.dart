import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'home_screen.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final controller = PageController();

  void dispose() {
    controller.dispose();
  }

  Widget snaptip1 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/center.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "Position the lego brick at \nthe center of the frame.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/no_side.png',
          height: 75,
          width: 75,
        ),
      ),
    ],
  );

  Widget snaptip2 =
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(1.0),
      child: Image.asset(
        'assets/bright.png',
        height: 75,
        width: 75,
      ),
    ),
    Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(6.0),
      child: const Text(
        "Ensure that the LEGO brick \nis adequately illuminated \nand that the image is free \nof blurring.",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    ),
    Container(
      margin: const EdgeInsets.all(1.0),
      padding: const EdgeInsets.all(1.0),
      child: Image.asset(
        'assets/no_blur.png',
        height: 75,
        width: 75,
      ),
    ),
  ]);

  Widget snaptip3 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/single.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "Make sure the picture        \nfeatures only 1 lego brick.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/no_multiple.png',
          height: 75,
          width: 75,
        ),
      ),
    ],
  );

  Widget snaptip4 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/plain.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "Place the lego brick against \na plain and contrasting \nbackground for better \nrecognition.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/no_print.png',
          height: 75,
          width: 75,
        ),
      )
    ],
  );

  Widget snaptip5 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/complete.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "Make sure the picture \nfeatures the entire LEGO.   ",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/no_cutoff.png',
          height: 75,
          width: 75,
        ),
      )
    ],
  );

  Widget feature1 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/help.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "Help: Redirects to onboarding pages to \nguide you take better pictures.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    ],
  );

  Widget feature2 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/history.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "History: View the recent properly           \nidentified bricks.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    ],
  );

  Widget feature3 = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(
          'assets/menu.png',
          height: 75,
          width: 75,
        ),
      ),
      Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(6.0),
        child: const Text(
          "Connect: Visit the UNT CSE             \nEngineering website for more               \ninformation.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    ],
  );
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
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Image(
                        image: AssetImage('assets/trans_logo2.png'),
                      ),
                    ),
                    const Text(
                      "Welcome to Brix-Color Finder",
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(11.0),
                      child: Text(
                        "Swipe left to read the instructions on how to use the app.  Click on the 'Skip boarding' button to access our app features",
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
                color: Colors.white,
                child: Column(
                  children: [
                    Text("", style: Theme.of(context).textTheme.displaySmall),
                    Text("", style: Theme.of(context).textTheme.displaySmall),
                    const Text(""),
                    const Text(
                      "Identify Lego Bricks In 3 Easy Steps",
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      'assets/onboard2.gif',
                      height: 600,
                      width: 600,
                      semanticLabel:
                          "take a picture\n crop the picture\n upload the picture\n view results",
                    ),
                    const Text("2/4"),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("", style: Theme.of(context).textTheme.displaySmall),
                      const Text(
                        "Snap Tips",
                        style: TextStyle(
                          fontFamily: 'Roboto Mono',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      snaptip1,
                      snaptip2,
                      snaptip3,
                      snaptip4,
                      snaptip5,
                      const Text("3/4"),
                    ]),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("", style: Theme.of(context).textTheme.displaySmall),
                    const Text(
                      "Features",
                      style: TextStyle(
                        fontFamily: 'Roboto Mono',
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    feature1,
                    feature2,
                    feature3,
                    const Text("4/4"),
                  ],
                ),
              ),
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
              count: 4,
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
