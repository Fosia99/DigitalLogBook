import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR1.dart';
import 'package:digital_logbook/LectureScreens/LogsIndirectR1.dart';
import 'package:digital_logbook/direct/postponed.dart';
import 'package:digital_logbook/indirect/canceled.dart';
import 'package:digital_logbook/indirect/postponed.dart';
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';
import '/direct/conduct.dart';
import 'LogsDirectR3.dart';
import 'LogsIndirectR3.dart';


class rotationThree extends StatefulWidget {
  late final docId;

  rotationThree(this.docId);

  static String TAG = "Planner";

  @override
  _rotationThreeState createState() => _rotationThreeState(docId);
}

class _rotationThreeState extends State<rotationThree> {
  final docId;

  _rotationThreeState(this.docId);

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
              LogsDirectR3(docId),
              LogsIndirectR3(docId),
            ]),
          )),
    );
  }
}
