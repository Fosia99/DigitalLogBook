

import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';




void main(){
  runApp(PlannerHome());
}

class PlannerHome extends StatefulWidget {
  static String TAG = "PlannerHome";
  @override
  PlannerHomeState createState() => PlannerHomeState();
}

class PlannerHomeState extends State<PlannerHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calender App",
      theme: ThemeData(
        primaryColor: LightColors.kGreen,
        accentColor: Colors.pinkAccent,
        backgroundColor: Colors.white,
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Icon(Icons.arrow_back_ios),
            elevation: 0,
            actions: [
              Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 6.0,
                    ),
                  )
                ],
              ),
            ],
          ),

      ),
    );
  }
}



