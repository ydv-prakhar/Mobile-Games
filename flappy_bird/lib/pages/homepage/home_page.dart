import 'dart:async';

import 'package:flappy_bird/pages/homepage/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double flapValue = 0;
  double time = 0;
  double height = 0;
  double initialHeight = flapValue;
  double velocity = 2.8;
  // bool gameHasStarted = 

  void jump() {
    initialHeight = flapValue;
    
  }

  void startGame(){
Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + velocity * time;
      setState(() {
        flapValue = initialHeight - height;
      });
      if (flapValue > 0) timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: jump,
                child: AnimatedContainer(
                  alignment: Alignment(0, flapValue),
                  duration: const Duration(milliseconds: 0),
                  color: Colors.blue,
                  child: const MyBird(),
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.green,
          ))
        ],
      ),
    );
  }
}
