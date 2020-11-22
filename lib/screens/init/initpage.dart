import 'package:dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:clipboard/clipboard.dart';

class Init extends StatefulWidget {
  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  String word = 'Apple';
  String types = 'VT';
  FlutterTts flutterTts = FlutterTts();

  speak() async {
    print(await flutterTts.getLanguages);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
  }

  copyWord() async {
    await FlutterClipboard.copy(word);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Spacer(
                  flex: 3,
                ),
                Text(
                  'Nice Dictionary',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                Image.asset('assets/images/landing.png'),
                Container(
                  height: size.height / 2,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36),
                      topRight: Radius.circular(36),
                    ),
                  ),
                  child: Column(
                    children: [
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          'assets/images/apple.png',
                          height: size.height / 10,
                        ),
                      ),
                      // Spacer(),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 50),
                        child: Text(
                          word,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 50),
                        child: Text(
                          'ผลไม้',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 210, left: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                    right: Radius.circular(10),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  types,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[600],
                                child: Icon(
                                  Icons.volume_up_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () => speak(),
                            ),
                            GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[600],
                                child: Icon(
                                  Icons.copy_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                copyWord();
                                SnackBar snack = SnackBar(
                                  content: Row(
                                    children: [
                                      Text('√   Copied'),
                                      Spacer(),
                                      Text('$word'),
                                    ],
                                  ),
                                  duration: Duration(seconds: 1),
                                );
                                Scaffold.of(context).removeCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(snack);
                              },
                            ),
                            GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: Colors.red[700],
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      // FlatButton(
                      //   onPressed: () {},
                      //   color: Colors.red,
                      //   child: Text('Next'),
                      // ),
                      SizedBox(
                        height: size.height / 15,
                        width: size.width / 2,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                              side: BorderSide(
                                color: Colors.white,
                              )),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/Home',
                            );
                          },
                          color: Colors.white,
                          child: Text(
                            'Next',
                            style:
                                TextStyle(fontSize: 24, color: kPrimaryColor),
                          ),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
