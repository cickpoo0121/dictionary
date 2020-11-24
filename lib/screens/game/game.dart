import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final TextEditingController _answer = TextEditingController();
  double count = 1.00;
  double time = 1.00;
  Timer timer;
  int score = 0;
  int _num = 0;
  String _result = '';
  String name;
  var pic = 'assets/images/chicken.jpg';

  void start() {
    // For every second
    // timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   // update counter
    //   setState(() {
    //     time -= 0.10;
    //     // stop timer
    //     if (time < -0.00) {
    //       time = 0.00;
    //       timer.cancel();
    //     }
    //   });
    // });
    picRandom();
  }

  void reset() {
    setState(() {
      time = 1.00;
      timer.cancel();
      score = 0;
    });
  }

  Future showAlert() async {
     await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  pic,
                  fit: BoxFit.cover,
                ),
                Text(
                  '$_result It is $name',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                )
              ],
            ),
          ),
        );
      },
    );
    ans();
    reset();
  }

  void ans() {
    if (_num == 0 && _answer.text == 'Chicken') {
      _result = 'Excellent!!';
      score = score++;
    } else if (_num == 1 && _answer.text == 'Car') {
      _result = 'Excellent!!';
      score = score++;
    } else if (_num == 2 && _answer.text == 'Tree') {
      _result = 'Excellent!!';
      score = score++;
    } else if (_num == 3 && _answer.text == 'Curtain') {
      _result = 'Excellent!!';
      score = score++;
    } else if (_num == 4 && _answer.text == 'Apple') {
      _result = 'Excellent!!';
      score = score++;
    } else {
      _result = 'Try again!!';
      score = score;
    }

    picRandom();
  }

  void picRandom() {
    setState(() {
      // _num = Random().nextInt(10);
      _num = Random().nextInt(5);
      if (_num == 0) {
        name = 'a chicken';
        pic = 'assets/images/chicken.jpg';
      } else if (_num == 1) {
        name = 'a car';
        pic = 'assets/images/car.jpg';
      } else if (_num == 2) {
        name = 'a tree';
        pic = 'assets/images/tree.jpg';
      } else if (_num == 3) {
        name = ' a curtain';
        pic = 'assets/images/curtain.jpg';
      } else {
        name = 'an apple';
        pic = 'assets/images/apple.jpg';
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vocabulary Game'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.alarm,
                  size: 30,
                  color: Color(0xFFFF6787),
                ),
                SizedBox(width: 5),
                Text(
                  ' Countdown ${time.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF3c4046),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Image.asset(
                            '$pic',
                            height: 200,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text('Lets guess the picture, What is this?',
                      style: TextStyle(fontSize: 18)),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _answer,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your answer',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('SCORE : $score', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 120.0,
                        height: 45.0,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.play_circle_filled_outlined),
                          color: Color(0xFFFF6787),
                          onPressed: start,
                          label: Text(
                            'Start',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ButtonTheme(
                        minWidth: 120.0,
                        height: 45.0,
                        child: RaisedButton.icon(
                          icon: Icon(Icons.question_answer),
                          color: Color(0xFFFF6787),
                          onPressed: showAlert,
                          label: Text(
                            'Answer',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
