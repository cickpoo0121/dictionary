import 'package:dictionary/constants.dart';
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
      length: 4,
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   elevation: 0,
          //   title: Text('Title'),
          // ),
          bottomNavigationBar: MyTabBar(),
          body: TabBarView(
            children: [
              // 1 Tab content
              HomeBody(),

              // 2 Tab content
              Container(
                child: Text('Train'),
                color: Colors.blue,
              ),

              // 3 Tab content
              Container(
                child: Text('Bike'),
                color: Colors.green,
              ),

              Container(
                child: Text('Bike'),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
