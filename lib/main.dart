import 'package:dictionary/constants.dart';
import 'package:dictionary/screens/home/components/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      // initialRoute: '/first',
      // routes: {
      //   '/first':(context)=>ListviewAss4(),
      //   '/second':(context)=>ListviewAss41()
      // },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        // accentColor: Colors.red[900],
        fontFamily: 'Lobster',
        textTheme: TextTheme(
          headline4: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
