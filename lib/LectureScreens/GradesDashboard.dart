
import 'package:digital_logbook/LectureScreens/StudentGrades.dart';
import 'package:digital_logbook/LectureScreens/rotations.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../theme/colors/light_colors.dart';
import 'MyStudents.dart';
import 'assessments.dart';


class GradesDashboard extends StatefulWidget{
  static String TAG ="dashboardNurse";

  late final docId;
  late final docName;

  GradesDashboard(this.docId,this.docName);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GradesDashboardState(docId,docName);
  }

}
class GradesDashboardState extends State<GradesDashboard>{

  final docId;
final docName;

  GradesDashboardState(this.docId,this.docName);
  @override
  Widget build(BuildContext context) {

    final rotOne='1';
    final rotTwo='2';
    final rotThree='3';
    final rotFour='4';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){

              Navigator.pushReplacement(context,
                MaterialPageRoute(
                  builder: (context) => const StudentsGrades(),
                ),
              );

            }
        ),
        backgroundColor: LightColors.kDarkYellow,
        title: Text( docName +" "+ "Grades Rotations"

      ),),
      body: Container(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>assessments(docId,docName,rotOne)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kDarkYellow,),
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>assessments(docId,docName,rotTwo)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kYellow,),
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>assessments(docId,docName,rotThree)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kBlack,),
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>assessments(docId,docName,rotFour)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kLightRed,),
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
