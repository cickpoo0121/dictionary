import 'package:dictionary/components/sqliteHelper.dart';
import 'package:flutter/material.dart';
import 'package:dictionary/constants.dart';
import 'package:dictionary/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:clipboard/clipboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeaningWord extends StatefulWidget {
  @override
  _MeaningWordState createState() => _MeaningWordState();
}

class _MeaningWordState extends State<MeaningWord> {
  String eng = '';
  String types = '';
  String thai = '';
  String esyn = '';
  String word = '';
  String data;
  bool isSaved = false;
  final GlobalKey scaffoldKey = GlobalKey();

  var dataA = []; // arguments
  var newData = [];
  List<String> stroeData = []; //keep data in local
  List<String> favorData = []; // keep favor word in local
  TextEditingController searchWord = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  SqliteHelper sqliteHelper = SqliteHelper();

// text to speech
  speak() async {
    // print(await flutterTts.getLanguages);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(eng);
  }

// copy wrod
  copyWord() async {
    await FlutterClipboard.copy(eng);
    // await Builder(
    //   builder: (BuildContext context) {
    //     return RaisedButton(
    //       child: Text('Show'),
    //       onPressed: () {
    //         SnackBar snack = SnackBar(
    //             content: Row(
    //           children: [
    //             Text('√   Copied'),
    //             Spacer(),
    //             Text(eng),
    //           ],
    //         ));
    //         Scaffold.of(context).showSnackBar(snack);
    //       },
    //     );
    //   },
    // );
  }

// query word from DB thath recive data from home page
  getWrod(word) async {
    dataA = await sqliteHelper.showWord(word);
    print(dataA);
    print(dataA[0]['NewEsyn']);

    await setState(() {
      eng = dataA[0]['esearch'];
    });
  }

// search word
  searchDB() async {
    word = await searchWord.text;
    newData = await sqliteHelper.showWord(word);
    await save();

    // print(newData);
    // print(newData);

    await setState(() {
      eng = newData[0]['esearch'];
      dataA = newData;
      print(dataA);
      // print(dataA[0]['NewEsyn']);
    });
  }

  void save() async {
    // get textfields data
    String saveWrod = searchWord.text;
    if (saveWrod != '') {
      SharedPreferences prefload = await SharedPreferences.getInstance();
      List<String> dataofStore = prefload.getStringList('kdata');
      if (dataofStore != null) {
        stroeData = dataofStore;
        SharedPreferences pref = await SharedPreferences.getInstance();
        if (stroeData.length == 20) {
          stroeData.removeAt(19);
        }
        stroeData.insert(0, saveWrod);
        pref.setStringList('kdata', stroeData);
      }
      if (dataofStore == null) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        if (stroeData.length == 20) {
          stroeData.removeAt(19);
        }
        stroeData.insert(0, saveWrod);
        pref.setStringList('kdata', stroeData);
      }
    } else {}
  }

  void saveFavorWord() async {
    SharedPreferences prefload = await SharedPreferences.getInstance();
    List<String> dataofFavorWord = prefload.getStringList('fdata');
    if (dataofFavorWord != null) {
      favorData = dataofFavorWord;
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (favorData.length == 20) {
        favorData.removeAt(19);
      }

      setState(() {
        isSaved = favorData.contains(eng);
        if (isSaved == true) {
          isSaved = false;
          favorData.remove(eng);
          print(favorData);
          print(isSaved);
        } else {
          isSaved = true;
          favorData.add(eng);
          print(favorData);
          print(isSaved);
        }
      });

      pref.setStringList('fdata', favorData);
      // print(favorData);
    }
    if (dataofFavorWord == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (favorData.length == 20) {
        favorData.removeAt(19);
      }
      setState(() {
        isSaved = favorData.contains(eng);
        if (isSaved == true) {
          isSaved = false;
          favorData.remove(eng);
          print(favorData);
          print(isSaved);
        } else {
          isSaved = true;
          favorData.add(eng);
          print(favorData);
          print(isSaved);
        }
      });

      pref.setStringList('fdata', favorData);
    }
  }

  void loadFavorWord() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> dataofFavorWord = pref.getStringList('fdata');
    if (dataofFavorWord != null) {
      await setState(() {
        favorData = dataofFavorWord;
        isSaved = dataofFavorWord.contains(eng);
        if (isSaved == true) {
          isSaved = true;
        } else {
          isSaved = false;
        }

        // print(favorData);
      });
    } else {
      setState(() {
        // data = passdata;
        print('data Null');
        // print(data.length);
      });
    }
  }

  backpage() {
    // Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
    // Navigator.popAndPushNamed(context, '/Home');
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // sqliteHelper.openDB();
    (() async {
      await sqliteHelper.openDB();
      await getWrod(data);
      await loadFavorWord();
    })();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    onTap: backpage,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      // margin: EdgeInsets.only(right: kDefaultPadding),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: size.height / 15,
                      width: size.width / 1.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 15,
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchWord,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                // suffixIcon: Icon(Icons.search,size: 30,)
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.search,
                              color: kPrimaryColor.withOpacity(0.5),
                              size: 30,
                            ),
                            onTap: () => searchDB(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          eng,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontSize: 40,
                          ),
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
                                final state =
                                    scaffoldKey.currentState as ScaffoldState;
                                state.showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Text('√   Copied'),
                                        Spacer(),
                                        Text(eng),
                                      ],
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );

                                // SnackBar snack = SnackBar(
                                //   content: Row(
                                //     children: [
                                //       Text('√   Copied'),
                                //       Spacer(),
                                //       // Text(eng),
                                //     ],
                                //   ),
                                //   duration: Duration(seconds: 1),
                                // );
                                // Scaffold.of(context).removeCurrentSnackBar();
                                // Scaffold.of(context).showSnackBar(snack);
                                // showInSnackBar();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 15,
                                  color: kPrimaryColor.withOpacity(0.6),
                                )
                              ]),
                              child: CircleAvatar(
                                backgroundColor:
                                    isSaved ? Colors.red : Colors.white,
                                child: GestureDetector(
                                  child: Icon(
                                    isSaved
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: isSaved ? Colors.white : Colors.red,
                                  ),
                                  onTap: () {
                                    saveFavorWord();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/apple.png',
                    height: size.height / 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height / 1.5,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataA.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 110,
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  color: kPrimaryColor.withOpacity(0.5)),
                            ],
                          ),
                          // color: kPrimaryColor[200],
                          // color:Colors.pink,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      dataA[index]['tentry'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: kPrimaryColor),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10),
                                            right: Radius.circular(10),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          dataA[index]['ecat'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Sysnonyms is ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor
                                          // fontSize: 20,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      dataA[index]['NewEsyn'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                        //  ListTile(
                        //   title: Text(data[index]['title']),
                        //   // subtitle: Text(data[index]['subtitle']),
                        //   // trailing: SizedBox(
                        //   //   child: Image.asset(data[index]['image']),
                        //   //   height: 50,
                        //   //   width: 50,
                        //   // ),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
