//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' as math;

class Home_page extends StatefulWidget {
  Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  double? heading = 0;
  Color custom_value = Colors.black;
  bool isClieked = true;
  String mood = "Light";
  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: custom_value,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 143, 143, 143),
        centerTitle: true,
        title: Text("Compass"),
        actions: [
          Center(child: Text(mood)),
          Switch(
              activeColor: Colors.black,
              value: isClieked,
              onChanged: (value) {
                if (isClieked) {
                  setState(() {
                    isClieked = false;
                    custom_value = Colors.white;
                    mood = "Dark";
                  });
                } else {
                  setState(() {
                    isClieked = true;
                    custom_value = Colors.black;
                    mood = "Light";
                  });
                }
              }),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "${heading!.ceil()} degree",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: isClieked ? Colors.white : Colors.black),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              Image(
                image: AssetImage("assets/images/cadrant.png"),
                color: isClieked ? Colors.white : Colors.black,
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Transform.rotate(
                  angle: (heading! * (math.pi / 180) * -1),
                  child:Image(image: AssetImage("assets/images/compass.png"))
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
