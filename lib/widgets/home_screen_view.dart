import 'package:flutter/material.dart';

class HomeScreenView {
  Image appLogo() {
    return const Image(
      image: AssetImage('assets/trans_logo.png'),
      fit: BoxFit.scaleDown,
      height: 50,
    );
  }

  Semantics helpButton(BuildContext context) {
    return Semantics(
      label: "Help",
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 16,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Help\n\nFor issues with image detection, ensure you're in a sufficiently well lit room!\n\nAvoid placing the bricks on colorful surfaces.\n\nFor faster results, ensure your internet connection is stable.\n\nHaving problems with our app? feel free to email us at themissingsemicolon@brixcolor.com and we'll get back to you as soon as possible.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
        iconSize: 40,
        icon: const Icon(Icons.help),
        color: Colors.black,
        tooltip: "Help",
      ),
    );
  }

  Semantics menuOptions(BuildContext context) {
    return Semantics(
      label: "Menu options",
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 16,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Center(child: Text('Settings')),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text(
                        'Server Reconnect',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.cloud_upload_rounded,
                        size: 24.0,
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        alignment: Alignment.centerLeft,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.menu),
        color: Colors.black,
        iconSize: 40,
        tooltip: "Menu options",
      ),
    );
  }
}
