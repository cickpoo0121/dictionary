import 'package:flutter/material.dart';
import 'package:dictionary/screens/home/components/recent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteWord extends StatefulWidget {
  @override
  _FavoriteWordState createState() => _FavoriteWordState();
}

class _FavoriteWordState extends State<FavoriteWord> {
  List<String> favorData = []; // keep favor word in local

  void loadFavorWord() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> dataofFavorWord = pref.getStringList('fdata');
    if (dataofFavorWord != null) {
      setState(() {
        favorData = dataofFavorWord;
        // isSaved = dataofFavorWord.contains(eng);
        // if (isSaved == true) {
        //   isSaved = true;
        // } else {
        //   isSaved = false;
        // }

        print(favorData);
      });
    } else {
      setState(() {
        // data = passdata;
        print('data Null');
        // print(data.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    (() async {
      await loadFavorWord();
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text('FAVORITE'),
        ),
      ),
      body: Container(margin: EdgeInsets.only(top: 20),
        height: 480,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: favorData.length,
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
                        // '',
                        favorData[index],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                print(favorData);
                Navigator.pushNamed(
                  context,
                  '/Meaning',
                  arguments: favorData[index],
                );
              },
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
    );
  }
}
