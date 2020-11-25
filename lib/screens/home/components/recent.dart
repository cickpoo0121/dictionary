import 'package:flutter/material.dart';

class Recent extends StatefulWidget {
  const Recent({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List data;
  // final List<Map<String, dynamic>> data;


  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  @override
  void initState() {
    super.initState();

    (() async {
      await print(widget.data);
    })();
  }

  @override
  Widget build(BuildContext context)  {
    return Container(
      height: 480,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.data.length,
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
                      widget.data[index],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              print(widget.data);
              Navigator.pushNamed(
                context,
                '/Meaning',
                arguments: widget.data[index],
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
    );
  }
}
