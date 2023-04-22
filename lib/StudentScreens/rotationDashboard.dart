import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../direct/home.dart';
import '../indirect/home.dart';
import '../screens/OccupationalDashboardScreen.dart';
import '../screens/Planner.dart';
import '../screens/ProfilePage.dart';
import '../screens/timetable.dart';
import '../theme/colors/light_colors.dart';


class rotationDash extends StatefulWidget{
  static String TAG ="dashboardNurse";

  late final docId;
  late final rotNum;

  rotationDash(this.docId,this.rotNum);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return rotationDashState(docId,this.rotNum);
  }

}
class rotationDashState extends State<rotationDash>{

  final docId;
  late final rotNum;

  rotationDashState(this.docId,this.rotNum);
  var lstOptions = [
    {"icon": Image.asset('assets/images/otlog2.png'), "title": "LOG SESSION"},
    {"icon": Image.asset('assets/images/otplanner.png'), "title": "PLANNER"},
    {"icon": Image.asset('assets/images/otprofile.png'), "title": "PROFILE"},
    {"icon": Image.asset('assets/images/ottut.png'), "title": "TUTORIAL"},
    {"icon": Image.asset('assets/images/otreport.png'), "title": "REPORTS"},
    {
      "icon": Image.asset('assets/images/otmaterial.png'),
      "title": "STUDY MATERIALS"
    },
    {"icon": Image.asset('assets/images/otmaterial.png'), "title": "Log out"}
  ];

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    Stream<QuerySnapshot<Map<String, dynamic>>> indirect;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kGreen,
        title: Text(
          "Occupational Therapy  ---- Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          //IconButton(icon: Icon(Icons.search, color: Colors.grey,), onPressed: () {}),
        ],
      ),
      body:SingleChildScrollView(
          child:Container(
              child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 0)),
                    Row(
                        children: [
                          Expanded(
                            child :Container(
                              padding: EdgeInsets.only(top: 25),
                              height: 150,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('direct')
                                      .where('uid', isEqualTo: uid)
                                      .where('rotation', isEqualTo: rotNum)
                                      .snapshots(),

                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: Text(
                                          "No Sessions Added",
                                          style: const TextStyle(fontSize: 20, color: Colors.black),
                                        ),
                                      );
                                    }
                                    final documentSnapshotList = snapshot.data?.docs;
                                    var results = documentSnapshotList?.length;

                                    return Card(
                                        margin: EdgeInsets.all(10),
                                        shadowColor: Colors.black,
                                        color: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          /* side: const BorderSide(
                                        color: Colors.black, width: 1.5), */
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(top: 25),
                                                height: 80,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(10),
                                                      child: Text(
                                                        results.toString() +" Direct sessions",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ));
                                    // return
                                  }),
                            ),
                          ),
                          Expanded(
                            child: Container(

                              padding: EdgeInsets.only(top: 25),
                              height: 150,
                              child: StreamBuilder(

                                  stream: FirebaseFirestore.instance
                                      .collection('Indirect')
                                      .where('uid', isEqualTo: uid)
                                      .where('rotation', isEqualTo: rotNum)
                                      .snapshots(),

                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: Text(
                                          "No Sessions Added",
                                          style: const TextStyle(fontSize: 20, color: Colors.black),
                                        ),
                                      );
                                    }
                                    final documentSnapshotList = snapshot.data?.docs;
                                    var results = documentSnapshotList?.length;

                                    return Card(
                                        margin: const EdgeInsets.all(10),
                                        shadowColor: Colors.black,
                                        color: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          /* side: const BorderSide(
                                        color: Colors.black, width: 1.5), */
                                          borderRadius: BorderRadius.circular(5),
                                        ),

                                        child:
                                        Container(
                                          padding: EdgeInsets.only(top: 25),
                                          height: 80,

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  results.toString() +" Indirect sessions",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),

                                        ));
                                    // return
                                  }),
                            ),
                          ),
                        ]
                    ),

                  ]
              )
          )
      ),
      drawer: Drawer(
        backgroundColor: LightColors.kLightGreen,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: LightColors.kGreen,
                  image: DecorationImage(
                    image: AssetImage('assets/images/otplanner.png'),
                    fit: BoxFit.cover,
                  )),
              child: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: const Text('Home',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OccupationalDashboardScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: const Text('Direct Log Sessions',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DirectHome(rotNum),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: const Text('Indirect Log Sessions',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndirectHome(rotNum),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_outlined),
              title: const Text('Planner',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Planner(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: const Text('Timetable',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfPage(),
                  ),
                );
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
              },
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );

  }

}
