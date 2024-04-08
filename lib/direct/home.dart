
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digital_logbook/direct/postponed.dart';
import 'package:digital_logbook/indirect/canceled.dart';
import 'package:digital_logbook/indirect/postponed.dart';
import 'package:flutter/material.dart';
import '/theme/colors/light_colors.dart';
import '/direct/conduct.dart';
import 'canceled.dart';


class DirectHome extends StatefulWidget {
  //const Planner({Key? key}) : super(key: key);
  static String TAG ="Planner";

  late final rotNum;
  DirectHome(this.rotNum);

  @override
  _DirectHomeState createState() => _DirectHomeState(rotNum);


}

class _DirectHomeState extends State<DirectHome> {
  late final rotNum;
  _DirectHomeState(this.rotNum);

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {

    final Screen = [

      DirectCanceled(rotNum),
      DirectConduct(rotNum),
      DirectPostponed(rotNum),
    ];
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black,
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
