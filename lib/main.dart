import 'package:dictionary/constants.dart';
import 'package:dictionary/screens/home/components/meaningWord.dart';
import 'package:dictionary/screens/init/initpage.dart';
import 'package:dictionary/screens/home/components/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    MaterialApp(
      // home: Init(),
      initialRoute: '/Init',
      routes: {
        '/Init':(context)=>Init(),
        '/Home':(context)=>HomeScreen(),
        '/Meaning':(context)=>MeaningWord()
      },
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        // scaffoldBackgroundColor: Colors.white,
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
