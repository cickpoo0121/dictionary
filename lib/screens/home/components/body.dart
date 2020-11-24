import 'package:dictionary/components/sqliteHelper.dart';
import 'package:dictionary/constants.dart';
import 'package:dictionary/screens/home/components/head_search.dart';
import 'package:dictionary/screens/home/components/recent.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TextEditingController searchWord = TextEditingController();

  SqliteHelper sqliteHelper = SqliteHelper();
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataA = [];

  String word = '';

  searchDB() async {
    word = await searchWord.text;
    dataA = await sqliteHelper.searchDB(word);

    setState(() {
      data = dataA;
    });
    print(data);
    print(data[0]['tentry']); // await HomeBody(data: data);
    // return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqliteHelper.openDB();
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
                left: 270,
                top: -5,
                child: Image.asset(
                  'assets/images/home.png',
                  height: size.height / 4.3,
                  width: size.width / 2.4,
                ),
              ),
              Positioned(
                  left: 35,
                  bottom: 110,
                  child: Text(
                    'Nice Dictionary',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )),
              Positioned(
                top: 100,
                right: 0,
                left: 20,
                child: Container(
                  margin: EdgeInsets.only(right: kDefaultPadding + 80),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 54,
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
