import 'package:dictionary/components/sqliteHelper.dart';
import 'package:dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final TextEditingController _answer = TextEditingController();
  // double count = 1.00;
  int timeCount = 30;
  Timer timer;
  // int score = 0;
  int _num = 0;
  String _result = '';
  String name;
  String secretWord;
  String hint1 = '';
  String hint2 = '';
  List<String> displayWordList;
  List<String> wrongLettersGuessed;
  String displayWord;
  var data;
  SqliteHelper _sqlhelper = SqliteHelper();
  bool disableButtionStart = true;
  bool disableButtionAnswer = false;

  var pic = 'assets/images/chicken.jpg';

  void generateRandomWord() async {
    data = await _sqlhelper.randomDB();
    print(data[0]['ecat']);
    print(data);

    setState(() {
      secretWord = data[0]['esearch'];
      // hint = data[0]['tentry'];
    });
  }

  void initDisplayWordList() {
    displayWordList = [];
    for (int i = 0; i < secretWord.length; i++) displayWordList.add('_ ');
    for (int i = 0; i < (secretWord.length / 3); i++) {
      int n = Random.secure().nextInt(secretWord.length);
      if (displayWordList[n] == "_ ")
        replaceAll(secretWord[n]);
      else
        i++;
    }
    displayWord = displayWordList.join();
  }

  showHint1() {
    setState(() {
      hint1 = displayWord;
    });
  }

  showHint2() {
    setState(() {
      hint2 = data[0]['tentry'];
      // hint2 =
    });
  }

  void replaceAll(String letter) {
    for (int i = 0; i < secretWord.length; i++) {
      if (secretWord[i] == letter) {
        displayWordList[i] = letter;
      }
    }
  }

  start() async {
    // picRandom();
    await countTime();
    await generateRandomWord();
    await initDisplayWordList();

    setState(() {
      hint1 = '';
      hint2 = '';
      _result = '';
      name = '';
      disableButtionStart = false;
      disableButtionAnswer = true;
      picRandom();
    });
  }

  countTime() {
    timeCount = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeCount--;
        if (timeCount == 0) {
          timer.cancel();
          hint1 = '';
          hint2 = '';
          _result = '';
          name = '';
          disableButtionStart = true;
          disableButtionAnswer = false;
        }
      });
    });
  }

  cancelTimer() {
    timer.cancel();
  }

  Future showAlert() async {
    ans();
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
  }

  void ans() {
    setState(() {
      if (_answer.text == secretWord) {
        _result = 'Excellent!!';
        name = secretWord;
      } else {
        _result = 'Not Collect';
        name = 'Please try again';
      }
    });

    // showAlert();

    // if (_num == 0 && _answer.text == 'Chicken') {
    //   _result = 'Excellent!!';
    //   // score = score++;
    // } else if (_num == 1 && _answer.text == 'Car') {
    //   _result = 'Excellent!!';
    //   // score = score++;
    // } else if (_num == 2 && _answer.text == 'Tree') {
    //   _result = 'Excellent!!';
    //   // score = score++;
    // } else if (_num == 3 && _answer.text == 'Curtain') {
    //   _result = 'Excellent!!';
    //   // score = score++;
    // } else if (_num == 4 && _answer.text == 'Apple') {
    //   _result = 'Excellent!!';
    //   // score = score++;
    // } else {
    //   _result = 'Try again!!';
    //   // score = score;
    // }

    // picRandom();
  }

  void picRandom() {
    setState(() {
      // _num = Random().nextInt(10);
      _num = Random().nextInt(5);
      if (_num == 0) {
        // name = 'a chicken';
        pic = 'assets/images/chicken.jpg';
      } else if (_num == 1) {
        // name = 'a car';
        pic = 'assets/images/car.jpg';
      } else if (_num == 2) {
        // name = 'a tree';
        pic = 'assets/images/tree.jpg';
      } else if (_num == 3) {
        // name = ' a curtain';
        pic = 'assets/images/curtain.jpg';
      } else {
        // name = 'an apple';
        pic = 'assets/images/apple.png';
      }
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      timeCount = 30;
    });

    (() async {
      await _sqlhelper.openDB();
      // await start();
    })();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  ' Countdown $timeCount',
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
                  Text(
                    'Lets guess the picture, What is this?',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 10, right: 20, left: 20),
                    height: size.height / 15,
                    width: size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 15,
                          color: kPrimaryColor.withOpacity(0.5),
                        )
                      ],
                    ),
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
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      children: [
                        Text(
                          hint1,
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 30,
                          width: 80,
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: showHint1,
                            child: Text(
                              'HINT1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      children: [
                        Text(
                          hint2,
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 30,
                          width: 80,
                          child: RaisedButton(
                            color: Colors.green,
                            onPressed: showHint2,
                            child: Text(
                              'HINT2',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Text('SCORE : $score', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 120.0,
                        height: 45.0,
                        child: RaisedButton.icon(
                          icon: Icon(
                            Icons.play_circle_filled_outlined,
                            color: Colors.white,
                          ),
                          color: kPrimaryColor,
                          onPressed: disableButtionStart ? start : null,
                          label: Text(
                            'Start',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ButtonTheme(
                        minWidth: 120.0,
                        height: 45.0,
                        child: RaisedButton.icon(
                          icon: Icon(
                            Icons.question_answer,
                            color: Colors.white,
                          ),
                          color: kPrimaryColor,
                          onPressed: disableButtionStart ? null : showAlert,
                          label: Text(
                            'Answer',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
