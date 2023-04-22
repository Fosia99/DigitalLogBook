import 'package:digital_logbook/LectureScreens/RotationTwo/rotationTwo.dart';
import 'package:digital_logbook/LectureScreens/RotationThree/rotationThree.dart';
import 'package:digital_logbook/LectureScreens/RotationFour/rotationFour.dart';
import 'package:digital_logbook/LectureScreens/rotationOne.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR1.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../theme/colors/light_colors.dart';
import 'logsHome.dart';

class rotationsDashboard extends StatefulWidget{
  static String TAG ="dashboardNurse";

  late final docId;

  rotationsDashboard(this.docId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return rotationsDashboardState(docId);
  }

}
class rotationsDashboardState extends State<rotationsDashboard>{

  final docId;

  rotationsDashboardState(this.docId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rotations"),),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationOne(docId)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kLavender,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.one_x_mobiledata,size: 50,color: Colors.white,),
                  Text("Rotation 1",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationTwo(docId)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kRed,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.two_k,size: 50,color: Colors.white,),
                  Text("Rotation 2",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationThree(docId)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kBlue,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.threed_rotation_sharp,size: 50,color: Colors.white,),
                  Text("Rotation 3",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationFour(docId)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kDarkYellow,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.four_k,size: 50,color: Colors.white,),
                  Text("Rotation 4",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
        ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
        ),
      ),),
    );
  }
}
