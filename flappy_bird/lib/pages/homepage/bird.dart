import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 120,
        child: Image.asset('lib/images/flappybird.png'));
  }
}
