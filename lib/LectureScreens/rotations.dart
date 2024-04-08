import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR.dart';
import 'package:digital_logbook/LectureScreens/LogsIndirectR.dart';
import 'package:digital_logbook/direct/postponed.dart';
import 'package:digital_logbook/indirect/canceled.dart';
import 'package:digital_logbook/indirect/postponed.dart';
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';
import '/direct/conduct.dart';


class rotations extends StatefulWidget {
  late final docId;
  late final rotNum;
  late final docName;

  rotations(this.docId,this.docName,this.rotNum);

  static String TAG = "Planner";

  @override
  _rotationsState createState() => _rotationsState(docId,docName,rotNum);
}

class _rotationsState extends State<rotations> {
  final docId;
  late final rotNum;
  final docName;

  _rotationsState(this.docId,this.docName,this.rotNum);



  @override
  Widget build(BuildContext context) {
    final String name = docName;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: LightColors.kYellow,
              leading: IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),

              actions: [
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ],
              bottom: const TabBar(
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 16.0,fontFamily: 'Family Name'),
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
              studentLogsDirect(docId,name,rotNum),
              studentLogsIndirect(docId,name,rotNum),
            ]),
          )),
    );
  }
}
