// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:torch_controller/torch_controller.dart';
import 'package:flutter_app_2/componants/camera_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.camera1});

  final CameraDescription camera1;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final controller = TorchController();
  bool flash = false;

  @override
  Widget build(BuildContext context) {
    // getCamera();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Help!!\n\nFor issues with image detection, ensure you're in a sufficently well lit room!\n\nAvoid placing the bricks on colorful surfaces.\n\nFor faster results, ensure your internet connection is stable.\n\nHaving problems with out app? feel free to email us at themissingsemicolon@brixcolor.com and we'll get back to you as soon as possible.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          },
          iconSize: 40,
          icon: const Icon(Icons.help),
          color: Colors.black,
        ),
        leadingWidth: 75,
        toolbarHeight: 100,
        title: const Image(
          image: AssetImage('asset/trans_logo.png'),
          fit: BoxFit.scaleDown,
          height: 150,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 16,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        const Center(child: Text('Customize')),
                        const SizedBox(height: 20),
                        TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'Save to Gallery',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            Icons.save_alt,
                            size: 24.0,
                          ),
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              alignment: Alignment.centerLeft),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'Change Voice',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            Icons.man_outlined,
                            size: 24.0,
                          ),
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              alignment: Alignment.centerLeft),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: const Text(
                            'Server Reconnect',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          icon: const Icon(
                            Icons.cloud_upload_rounded,
                            size: 24.0,
                          ),
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              alignment: Alignment.centerLeft),
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
          )
        ],
      ),
      body: TakePictureScreen(
        camera: widget.camera1, // pass camera to widget
      ),
    );
  }
}
