import 'dart:async';

import 'package:flappy_bird/pages/homepage/barriers.dart';
import 'package:flappy_bird/pages/homepage/bird.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
        if (barrierXone < -1.5) {
          barrierXone += 3.3;
        } else {
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if (barrierXtwo < -1.5) {
          barrierXtwo += 3.3;
        } else {
          barrierXtwo -= 0.05;
        }
      });
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
    });
  }

  bool birdIsDead() {
    if (flapValue > 1) {
      return true;
    } else {
      return false;
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      flapValue = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = flapValue;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          );
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
                onTap: () {
                  if (gameHasStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, flapValue),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text(" ")
                          : const Text(
                              "T A P  T O  P L A Y  !",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                ),
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
