import 'dart:async';

import 'package:flappy_bird/pages/homepage/barriers.dart';
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
  bool gameHasStarted = false;
  static double barrierXone = 1.5;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = flapValue;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + velocity * time;
      setState(() {
        flapValue = initialHeight - height;
        barrierXone -= 0.05;
        barrierXtwo -= 0.05;
      });
      setState(() {
        if (barrierXone < 1.1) {
          barrierXone += 2.3;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (flapValue > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (gameHasStarted) {
                        jump();
                      } else {
                        startGame();
                      }
                    },
                    child: AnimatedContainer(
                      alignment: Alignment(0, flapValue),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gameHasStarted
                        ? const Text(" ")
                        : const Text(
                            "T A P  T O  P L A Y  !",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXone, 1.1),
                      child: const MyBarrier(size: 200.0)),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXone, -1.1),
                      child: const MyBarrier(size: 200.0)),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXtwo, 1.1),
                      child: const MyBarrier(size: 250.0)),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      alignment: Alignment(barrierXtwo, -1.1),
                      child: const MyBarrier(size: 150.0)),
                ],
              )),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Score",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Best Score",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
