import 'package:dictionary/constants.dart';
import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.3),
          ),
        ],
      ),
      child: TabBar(
        tabs: [
          Tab(
            icon: Icon(
              Icons.home_outlined,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.favorite_outline,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.videogame_asset_outlined,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
