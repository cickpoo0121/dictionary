import 'package:dictionary/constants.dart';
import 'package:dictionary/screens/home/components/head_search.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Map<String, dynamic>> data = [
    {
      'title': 'Apple1',
      'subtitle': '9 baht',
      'image': 'assets/images/apple.jpg'
    },
    {
      'title': 'Banana1',
      'subtitle': '3 baht',
      'image': 'assets/images/banana.png'
    },
    {
      'title': 'Orange1',
      'subtitle': '5 baht',
      'image': 'assets/images/orange.png'
    },
    {
      'title': 'Kiwi1',
      'subtitle': '14 baht',
      'image': 'assets/images/kiwi.png'
    },
    {
      'title': 'Apple2',
      'subtitle': '9 baht',
      'image': 'assets/images/apple.jpg'
    },
    {
      'title': 'Banana2',
      'subtitle': '3 baht',
      'image': 'assets/images/banana.png'
    },
    {
      'title': 'Orange2',
      'subtitle': '5 baht',
      'image': 'assets/images/orange.png'
    },
    {
      'title': 'Kiwi2',
      'subtitle': '14 baht',
      'image': 'assets/images/kiwi.png'
    },
    {
      'title': 'Orange2',
      'subtitle': '5 baht',
      'image': 'assets/images/orange.png'
    },
    {
      'title': 'Kiwi2',
      'subtitle': '14 baht',
      'image': 'assets/images/kiwi.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadSearch(),
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
        Container(
          height: 480,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: SizedBox(
                  height: 70,
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data[index]['title'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
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
        )
      ],
    );
  }
}
