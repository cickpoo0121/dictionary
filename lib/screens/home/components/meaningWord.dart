import 'package:dictionary/screens/home/components/head_search.dart';
import 'package:flutter/material.dart';
import 'package:dictionary/constants.dart';
import 'package:dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:clipboard/clipboard.dart';

class MeaningWord extends StatefulWidget {
  @override
  _MeaningWordState createState() => _MeaningWordState();
}

class _MeaningWordState extends State<MeaningWord> {
  String word = 'Apple';
  String types = 'VT';
  FlutterTts flutterTts = FlutterTts();

  @override
  speak() async {
    print(await flutterTts.getLanguages);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(word);
  }

  copyWord() async {
    await FlutterClipboard.copy(word);
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text('Title'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blueAccent,
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0))),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // color: kPrimaryColor,
                  height: 200,
                  width: 340,
                  child: Column(
                    children: [
                      Text(
                        'Apple',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'ผลไม้เมืองหนาวที่นิยมรับประทานกันทั่วโลก ด้วยผลขนาดพอเหมาะ ผลมีสีสันสวยงาม เปลือกผลบาง เนื้อผลกรอบ'),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
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
                          SizedBox(
                            width: 10,
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
                          SizedBox(
                            width: 10,
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
                    ],
                  ),
                ),
                 SizedBox(
                  height: 20,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // color: kPrimaryColor,
                  height: 200,
                  width: 340,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'You can add border by passing border property. It must be a BoxBorder. You can create it using various ways such as the Border() constructor, Border.all factory, or Border.merge static method. Border is drawn on top of everything including color, gradient, or image which will be explained later.'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sysnonyms for Apple',
                  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20,),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Apple, Apple, Apple, Apple, Apple,')
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
