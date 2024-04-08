import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR.dart';
import 'package:digital_logbook/LectureScreens/LogsIndirectR.dart';
import 'package:digital_logbook/direct/postponed.dart';
import 'package:digital_logbook/indirect/canceled.dart';
import 'package:digital_logbook/indirect/postponed.dart';
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';
import '/direct/conduct.dart';
import 'assessmentsLog.dart';


class assessments extends StatefulWidget {
  late final docId;
  late final rotNum;
  late final docName;

  assessments(this.docId,this.docName,this.rotNum);

  static String TAG = "Planner";

  @override
  _assessmentsState createState() => _assessmentsState(docId,docName,rotNum);
}

class _assessmentsState extends State<assessments> {
  final docId;
  final docName;
  late final rotNum;

  _assessmentsState(this.docId,this.docName,this.rotNum);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: LightColors.kDarkYellow,
              leading: IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),

              actions: [
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ],
              bottom: const TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: "Direct Logs Grades",
                    ),
                    Tab(
                      text: "Indirect Logs Grades",
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              assessmentsLogs(docId,docName,rotNum),
              assessmentsLogs(docId,docName,rotNum),
            ]),
          )),
    );
  }
}
