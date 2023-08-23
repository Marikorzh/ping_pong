import 'package:flutter/material.dart';

class ConverScreen extends StatelessWidget {
  final bool gameHasStarted;
  const ConverScreen({Key? key, required this.gameHasStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0,-0.2),
      child: Text(!gameHasStarted ? "T A P TO P L A Y" : "", style: TextStyle(color: Colors.white),),
    );
  }
}
