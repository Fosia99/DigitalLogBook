
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/DoingTodo.dart';
import '/DoneTodo.dart';
import '/TodoMain.dart';
import '/theme/colors/light_colors.dart';
import 'OccupationalDashboardScreen.dart';


class Planner extends StatefulWidget {
  //const Planner({Key? key}) : super(key: key);
  static String TAG ="Planner";
  @override
  _PlannerState createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  int currentIndex = 1;
  final Screen = [
    DoingTodo(),
    TodoMain(),
    DoneTodo(),
  ];
  @override
  Widget build(BuildContext context) {
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(


      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:  LightColors.kGreen,
          height: 40,
          index: 1,
          onTap: (currentIndex) => setState(() {
            this.currentIndex = currentIndex;
          }),
          items: const [
            Icon(Icons.run_circle_rounded),
            Icon(Icons.task),
            Icon(Icons.done_all)
          ]),
      /* appBar: AppBar(
        title: const Text('Todo Planner'),
        centerTitle: true,
      ), */
      body: Screen[currentIndex],

    );


  }

}
