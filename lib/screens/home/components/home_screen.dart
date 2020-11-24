import 'package:dictionary/constants.dart';
import 'package:dictionary/screens/favorite/favorite.dart';
import 'package:dictionary/screens/game/game.dart';
import 'package:dictionary/screens/history/history.dart';
import 'package:dictionary/screens/home/components/body.dart';
import 'package:dictionary/screens/home/components/tabbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          //   title: Text('Title'),
          // ),
          bottomNavigationBar: MyTabBar(),
          body: TabBarView(
            children: [
              // 1 Tab Home
              HomeBody(),

              // 2 Tab Favorite
              FavoriteWord(),

              // 3 Tab Game
              Game(),
            ],
          ),
        ),
      ),
    );
  }
}
