
import '/StudentScreens/rotationDashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/theme/colors/light_colors.dart';

class OccupationalDashboardScreen extends StatefulWidget {
  static String TAG = "OTDashboard";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OccupationalDashboardScreenState();
  }
}

class OccupationalDashboardScreenState extends State<OccupationalDashboardScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final docId = user?.uid.toString();
    final rotOne='1';
    final rotTwo='2';
    final rotThree='3';
    final rotFour='4';

    return Scaffold(
      appBar: AppBar(title: const Text("Rotations",
      ),
        backgroundColor: LightColors.kDarkBlue,),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationDash(docId,rotOne)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kDarkYellow,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.one_x_mobiledata,size: 50,color: Colors.white,),
                  Text("Rotation 1",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationDash(docId,rotTwo)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kYellow,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.two_k,size: 50,color: Colors.white,),
                  Text("Rotation 2",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationDash(docId,rotThree)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kBlack,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.threed_rotation_sharp,size: 50,color: Colors.white,),
                  Text("Rotation 3",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>rotationDash(docId,rotFour)));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: LightColors.kLightRed,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.four_k,size: 50,color: Colors.white,),
                  Text("Rotation 4",style: TextStyle(color: Colors.white,fontSize: 30),)
                ],),
            ),
          ),
        ],
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
        ),
      ),
    );
  }
}

