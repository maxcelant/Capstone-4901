import 'package:flutter/material.dart';
import 'package:flutter_app_2/components/on_boarding.dart';
import '../classes/brick.dart';
import '../components/predicted_bricks_screen.dart';

class HomeScreenView {
  Image appLogo() {
    return const Image(
      image: AssetImage('assets/trans_logo3.png'),
      fit: BoxFit.scaleDown,
      height: 50,
    );
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

  Semantics predictedCacheButton(BuildContext context, List<Brick> legoCache) {
    return Semantics(
      label: "Predicted Lego Bricks",
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PredictedBricksScreen(legoCache)),
          );
        },
        iconSize: 40,
        icon: const Icon(Icons.history),
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
