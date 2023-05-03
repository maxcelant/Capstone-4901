import 'package:flutter/material.dart';
import '../classes/brick.dart';


class PredictedBricksScreen extends StatelessWidget {
  final List<Brick> legoCache;

  PredictedBricksScreen(this.legoCache);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 75,
        toolbarHeight: 75,
        title: const Text(
          "Recent Bricks",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'WorkSans'),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 232, 232),
        shadowColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: legoCache.length,
        itemBuilder: (context, index) {
          final brick = legoCache[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.file(brick.image!, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          brick.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'WorkSans'),
                        ),
                        Text(
                          'Color: ${brick.color}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 52, 52, 52),
                              fontSize: 16,
                              fontFamily: 'WorkSans'),
                        ),
                        Text(
                          'Accuracy: ${brick.accuracy}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 52, 52, 52),
                              fontSize: 16,
                              fontFamily: 'WorkSans'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}