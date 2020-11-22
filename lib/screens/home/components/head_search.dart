import 'package:dictionary/constants.dart';
import 'package:flutter/material.dart';

class HeadSearch extends StatelessWidget {
  const HeadSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          Container(
            height: size.height/4.3,
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
              height: size.height/4.3,
              width: size.width/2.4,
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
                  Icon(
                    Icons.search,
                    color: kPrimaryColor.withOpacity(0.5),
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
