import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double x;
  final double y;
  const MyBall({Key? key, required this.x, required this.y}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x,y),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: 20,
        height: 20,
      ),
    );
  }
}
