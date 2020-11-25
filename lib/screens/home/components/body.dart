import 'dart:convert';

import 'package:dictionary/components/sqliteHelper.dart';
import 'package:dictionary/constants.dart';
import 'package:dictionary/screens/home/components/head_search.dart';
import 'package:dictionary/screens/home/components/recent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TextEditingController searchWord = TextEditingController();

  SqliteHelper sqliteHelper = SqliteHelper();

  List<String> data = [];
  // List<Map<String, dynamic>> data=[];
  List<Map<String, dynamic>> dataA = [];
  List<String> stroeData = [];

  List<String> passdata = ['No Data'];

  String word = '';

  searchDB() async {
    word = await searchWord.text;
    dataA = await sqliteHelper.searchDB(word);
    await save();
    await load();

    // await setState(() {
    //   data = dataA;
    // });

    await print(dataA);

    // await Navigator.pushNamed(context, '/Meaning',
    //     arguments: dataA[0]['esearch']);

    Navigator.pushNamedAndRemoveUntil(context, '/Meaning', (route) => false,
        arguments: dataA[0]['esearch']);

    // print(data[0]['tentry']); // await HomeBody(data: data);
    // return data;
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

  void load() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> dataofStore = pref.getStringList('kdata');

    if (dataofStore != null) {
      setState(() {
        data = dataofStore;
        print(data);
      });
    } else {
      setState(() {
        data = passdata;
        print('data Null');
        // print(data.length);
      });
    }
  }

  void clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  void initState() {
    super.initState();

    (() async {
      await sqliteHelper.openDB();
      await load();
      // await clear();
    })();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Stack(
            children: [
              Container(
                height: size.height / 4.3,
                // height: 200,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
              ),
              Positioned(
                left: size.width / 1.7,
                top: -5,
                child: Image.asset(
                  'assets/images/home.png',
                  height: size.height / 4.3,
                  width: size.width / 2.4,
                ),
              ),
              Positioned(
                  left: 35,
                  bottom: size.height / 8,
                  child: Text(
                    'Nice Dictionary',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )),
              Positioned(
                top: size.height / 9,
                right: 0,
                left: 20,
                child: Container(
                  margin: EdgeInsets.only(right: kDefaultPadding + 80),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: size.height / 15,
                  // width: size.width/1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryColor.withOpacity(0.23),
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
          height: 20,
        ),
        Text(
          'Recent',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Recent(data: data)
        // Container(
        //   height: 480,
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: data.length,
        //     scrollDirection: Axis.vertical,
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //         child: SizedBox(
        //           height: 70,
        //           child: Card(
        //             child: Row(
        //               children: [
        //                 SizedBox(
        //                   width: 10,
        //                 ),
        //                 Text(
        //                   data[index]['esearch'],
        //                   textAlign: TextAlign.center,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //       //  ListTile(
        //       //   title: Text(data[index]['title']),
        //       //   // subtitle: Text(data[index]['subtitle']),
        //       //   // trailing: SizedBox(
        //       //   //   child: Image.asset(data[index]['image']),
        //       //   //   height: 50,
        //       //   //   width: 50,
        //       //   // ),
        //       // );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
