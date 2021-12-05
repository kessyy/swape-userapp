import 'package:flutter/material.dart';
import 'package:swape_user_app/view/screen/home/Men.dart';
import 'package:swape_user_app/view/screen/home/women.dart';
import 'package:swape_user_app/view/screen/home/kids.dart';
import 'package:swape_user_app/view/screen/home/home_screen.dart';

import 'package:flutter/rendering.dart';

void main() => runApp(MaterialApp());

class Categories extends StatelessWidget {
  final bool isHomePage;
  Categories({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: SizedBox(
        child: Container(
          color: Colors.white,
          height: 25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              InkWell(
                child: Container(
                  width: 70,
                  child: const Center(
                      child: Text(
                    'ALL',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'TitilliumWeb',
                    ),
                  )),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => HomePageScreen()));
                },
              ),
              InkWell(
                child: Container(
                  width: 70,
                  child: const Center(
                      child: Text(
                    'WOMEN',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TitilliumWeb',
                        color: Colors.black),
                  )),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => WomenScreen()));
                  color:
                  Colors.white;
                },
              ),
              InkWell(
                child: Container(
                  width: 50,
                  child: const Center(
                      child: Text(
                    'MEN',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TitilliumWeb',
                        color: Colors.black),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MenScreen()));
                },
              ),
              InkWell(
                child: Container(
                  width: 70,
                  child: const Center(
                      child: Text(
                    'KIDS',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TitilliumWeb',
                        color: Colors.black),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => KidsScreen()));
                },
              ),
              InkWell(
                child: Container(
                  // width: 70,

                  child: const Center(
                      child: Text(
                    'INTERIOR DESIGN',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TitilliumWeb',
                        color: Colors.black),
                  )),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => KidsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
