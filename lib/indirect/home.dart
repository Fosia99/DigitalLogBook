
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_logbook/indirect/canceled.dart';
import 'package:digital_logbook/indirect/postponed.dart';
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';
import 'conduct.dart';


class IndirectHome extends StatefulWidget {
  late final rotNum;

  IndirectHome(this.rotNum);

  static String TAG ="Planner";
  @override
  _IndirectHomeState createState() => _IndirectHomeState(rotNum);
}

class _IndirectHomeState extends State<IndirectHome> {
  late final rotNum;

  _IndirectHomeState(this.rotNum);
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final Screen = [

      IndirectCanceled(rotNum),
      IndirectConduct(rotNum),
      IndirectPostponed(rotNum),
    ];
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(


      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor:  LightColors.kDarkYellow,
          height: 40,
          index: 1,
          onTap: (currentIndex) => setState(() {
            this.currentIndex = currentIndex;
          }),
          items: const [
            Text("Canceled",
            style:TextStyle(
                fontSize: 16,
                color: Colors
                    .black,
                fontWeight:
                FontWeight
                    .bold)),
            Text("Conduct",
                style:TextStyle(
                    fontSize: 16,
                    color: Colors
                        .black,
                    fontWeight:
                    FontWeight
                        .bold)),
            Text("Postponed",
                style:TextStyle(
                    fontSize: 16,
                    color: Colors
                        .black,
                    fontWeight:
                    FontWeight
                        .bold)),
          ]),
      /* appBar: AppBar(
        title: const Text('Todo Planner'),
        centerTitle: true,
      ), */
      body: Screen[currentIndex],

    );


  }

}
