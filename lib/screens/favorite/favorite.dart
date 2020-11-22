import 'package:flutter/material.dart';
import 'package:dictionary/screens/home/components/recent.dart';

class FavoriteWord extends StatefulWidget {
  @override
  _FavoriteWordState createState() => _FavoriteWordState();
}

class _FavoriteWordState extends State<FavoriteWord> {
  @override
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


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text('FAVORITE'),
          ),
        ),
        body: Column(
          children: [
            Recent(data: data)
          ],
        ));
  }
} 