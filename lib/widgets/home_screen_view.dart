import 'package:flutter/material.dart';
import 'package:flutter_app_2/components/on_boarding.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenView {
  Image appLogo() {
    return const Image(
      image: AssetImage('assets/trans_logo3.png'),
      fit: BoxFit.scaleDown,
      height: 50,
    );
  }

  _launchURLSD() async {
    const url = 'https://engineering.unt.edu/capstone';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLCE() async {
    const url = 'https://engineering.unt.edu/';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Semantics helpButton(BuildContext context) {
    return Semantics(
      label: "Help",
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnBoarding()),
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
                    const Center(
                        child: Text(
                      'Connect with us',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: _launchURLSD,
                      label: const Text(
                        'Visit Senior Design Website',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.link,
                        size: 24.0,
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _launchURLCE,
                      label: const Text(
                        'Visit College of Engineering Website',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(
                        Icons.link,
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
