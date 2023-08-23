import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ping_pong/ball.dart';
import 'package:ping_pong/brick.dart';
import 'package:ping_pong/converscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

  enum direction {UP, DOWN, LEFT, RIGHT}

class _HomePageState extends State<HomePage> {

  //player values (bottom bricks)
  double playerX = -0.2;
  double enemyX = -0.2;
  double brickWidth = 0.4;
  int scoreAI = 0; //meeeeee

  bool isPressed = false;

  //ball values
  double ballX = 0.01;
  double ballY = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  bool gameHasStarted = false;


  void startGame(){
    if(!gameHasStarted) {
      gameHasStarted = true;
      Timer.periodic(Duration(milliseconds: 1), (timer) {
        // update direction
        updateDirection();

        //move ball
        moveBall();

        moveEnemy();

        //check player life
        if(isPlayerDead()){
          timer.cancel();
          resetGame();
        }
      });
    }
  }

  void moveEnemy(){
    setState(() {
      enemyX = ballX;
    });
  }

  void closeAlert(){
    Navigator.of(context).pop();
  }


  void resetGame(){
    if(scoreAI == 10) {
      scoreAI = 0;
      _showDialog();
    }
    setState(() {
      gameHasStarted = false;
      ballX = 0.01;
      ballY = 0.01;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }

  bool isPlayerDead(){
    if(ballY >= 1) {
      scoreAI++;
      return true;
    }
    return false;
  }

  void updateDirection(){
    setState(() {
      //update vertical movement
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      }
      else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      //update horizontal movement
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      }
      else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall(){
    double speedBall = 0.003;
    setState(() {
      // vertical direction
      if(ballYDirection == direction.DOWN){
        ballY += speedBall;
      }
      else if(ballYDirection == direction.UP){
        ballY -= speedBall;
      }

      // horizontal direction
      if(ballXDirection == direction.LEFT){
        ballX -= speedBall;
      }
      else if(ballXDirection == direction.RIGHT){
        ballX += speedBall;
      }
    });

  }

  void moveLeft(){
    const duration = Duration(milliseconds: 100);
    Timer.periodic(duration, (Timer timer) {
      if (!isPressed) {
        timer.cancel();
      } else {
        setState(() {
          if(playerX <= -0.9){
            isPressed = false;
          }
          else {
            playerX -= 0.2;
          }
        });
      }
    });
  }

  void moveRight(){
    const duration = Duration(milliseconds: 100);
    Timer.periodic(duration, (Timer timer) {
      if (!isPressed) {
        timer.cancel();
      } else {
        setState(() {
          if(playerX >= 0.6){
            isPressed = false;
          }
          else {
            playerX += 0.2;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: startGame,
          child: Scaffold(
            backgroundColor: Colors.grey.shade900,
            body: Center(
              child: Stack(
                children: [

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTapDown: (_){
                            setState(() {
                              isPressed = true;
                            });
                            moveLeft();
                          },
                          onTapUp: (_){
                            setState(() {
                              isPressed = false;
                            });
                          },
                          onTapCancel: (){isPressed = false;},
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.grey.shade900,
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (_){
                            setState(() {
                              isPressed = true;
                            });
                            moveRight();
                          },
                          onTapUp: (_){
                            setState(() {
                              isPressed = false;
                            });
                          },
                          onTapCancel: (){isPressed = false;},
                          child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.grey.shade900,
                          ),
                        ),],
                    ),
                  ),

                  //tap to play
                  ConverScreen(gameHasStarted: gameHasStarted,),

                  //screen score
                  Container(
                      alignment: Alignment(0,-0.2),
                      child: Text(scoreAI.toString(), style: TextStyle(color: Colors.grey.shade700, fontSize: 50),)
                  ),
                  //score screen
                  Container(
                    alignment: Alignment(0,0),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Container(
                      alignment: Alignment(0,0.2),
                      child: Text("0", style: TextStyle(color: Colors.grey.shade700, fontSize: 50),)
                  ),

                  //top brick
                   MyBrick(
                     x: enemyX,
                     y: -0.9,
                     brickWidth: brickWidth,
                     thisIsEnemy: true,),

                  //bottom brick
                   MyBrick(x: playerX, y: 0.9, brickWidth: brickWidth, thisIsEnemy: false,),

                  //ball
                  MyBall(x: ballX, y: ballY),

                  Container(
                    alignment: Alignment(playerX, 0.9),
                    child: Container(
                      width: 2,
                      height: 20,
                      color: Colors.red,
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      );
  }

  void _showDialog(){
    String text = "PURPLE WIN";
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(text,
              style: TextStyle(color: Colors.white)),
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: closeAlert,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.deepPurple.shade100,
                      child: Text(
                        "PLAY AGAIN",
                        style: TextStyle(color: Colors.deepPurple.shade800),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
