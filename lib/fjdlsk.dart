import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom-Aligned Row Example'),
      ),
      body: Align(
        alignment: Alignment(1,1),
        child: Container(
          width: 50,
          height: 50,
          color: Colors.redAccent,
        ),
      )
    );
  }
}