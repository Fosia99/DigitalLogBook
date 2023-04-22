import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR1.dart';
import 'package:digital_logbook/LectureScreens/LogsIndirectR1.dart';
import 'package:digital_logbook/direct/postponed.dart';
import 'package:digital_logbook/indirect/canceled.dart';
import 'package:digital_logbook/indirect/postponed.dart';
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';
import '/direct/conduct.dart';
import 'LogsDirectR4.dart';
import 'LogsIndirectR4.dart';


class rotationFour extends StatefulWidget {
  late final docId;

  rotationFour(this.docId);

  static String TAG = "Planner";

  @override
  _rotationFourState createState() => _rotationFourState(docId);
}

class _rotationFourState extends State<rotationFour> {
  final docId;

  _rotationFourState(this.docId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "My Students Sessions Plans",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () {}),
              ],
              bottom: const TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: "Direct Sessions",
                    ),
                    Tab(
                      text: "Indirect Sessions",
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              LogsDirectR4(docId),
              LogsIndirectR4(docId),
            ]),
          )),
    );
  }
}
