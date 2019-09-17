import 'package:flutter/material.dart';
import 'dart:math';

import './colorCard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum Difficulty {
  easy,
  hard,
}

class _HomePageState extends State<HomePage> {
  Color steelBlue = Color(0xFF5581B0);

  Difficulty diffLevel = Difficulty.easy;
  List<Color> randomColors = [];
  int r, g, b;
  Color pickedColor;
  Color headColor = Color(0xFF5581B0);
  String status = '';

  _HomePageState() {
    generateRandomColors();
  }

  generateRandomColors() {
    int n;
    randomColors = [];
    for (var i = 0; i < 4; i++) {
      int r = Random().nextInt(256);
      int g = Random().nextInt(256);
      int b = Random().nextInt(256);
      randomColors.add(Color.fromRGBO(r, g, b, 1));
    }
    if (diffLevel == Difficulty.hard) {
      n = Random().nextInt(4);
    } else if (diffLevel == Difficulty.easy) {
      n = Random().nextInt(2);
    }
    pickedColor = randomColors[n];
    r = pickedColor.red;
    g = pickedColor.green;
    b = pickedColor.blue;
  }

  reset() {
    headColor = steelBlue;
    status = '';
    generateRandomColors();
  }

  checkColor(int i) {
    if (randomColors[i] == pickedColor) {
      setState(() {
        status = 'Correct';
        headColor = pickedColor;
        randomColors = [pickedColor, pickedColor, pickedColor, pickedColor];
      });
    } else {
      setState(() {
        status = 'Try Again';
        randomColors[i] = Color(0xFF232323);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232323),
      appBar: AppBar(
        backgroundColor: Color(0xFF232323),
        title: Text('Color Game'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: headColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'The Great'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'RGB($r, $g, $b)',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Color Game'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        child: FlatButton(
                          child: Text(
                            'Play Again',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: steelBlue,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              reset();
                            });
                          },
                        ),
                      ),
                      Text(
                        '$status'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            color: diffLevel == Difficulty.easy
                                ? steelBlue
                                : Colors.white,
                            height: double.infinity,
                            width: 70,
                            child: FlatButton(
                              child: Text(
                                'Easy',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: diffLevel == Difficulty.easy
                                      ? Colors.white
                                      : steelBlue,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  diffLevel = Difficulty.easy;
                                  reset();
                                });
                              },
                            ),
                          ),
                          Container(
                            color: diffLevel == Difficulty.hard
                                ? steelBlue
                                : Colors.white,
                            height: double.infinity,
                            width: 70,
                            child: FlatButton(
                              child: Text(
                                'Hard',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: diffLevel == Difficulty.hard
                                      ? Colors.white
                                      : steelBlue,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  diffLevel = Difficulty.hard;
                                  reset();
                                });
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                color: Color(0xFF232323),
                child: diffLevel == Difficulty.easy
                    ? Column(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () => checkColor(0),
                              child: ColorCard(randomColors[0]),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => checkColor(1),
                              child: ColorCard(randomColors[1]),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => checkColor(0),
                                    child: ColorCard(randomColors[0]),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => checkColor(1),
                                    child: ColorCard(randomColors[1]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => checkColor(2),
                                    child: ColorCard(randomColors[2]),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => checkColor(3),
                                    child: ColorCard(randomColors[3]),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
