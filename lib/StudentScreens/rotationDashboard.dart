import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../direct/home.dart';
import '../indirect/home.dart';
import '../planner/screens/home_page.dart';
import '../screens/OccupationalDashboardScreen.dart';
import '../screens/Planner.dart';
import '../screens/ProfilePage.dart';
import '/StudentScreens/planner.dart';
import '../screens/timetable.dart';
import '../theme/colors/light_colors.dart';
import 'Tutorials/screens/dashboard_screen.dart';
import 'logs.dart';
import 'Outputs/outputs.dart';
import 'package:digital_logbook/reports/screens/home/home_screen.dart';

class rotationDash extends StatefulWidget {
  static String TAG = "dashboardNurse";

  late final docId;
  late final rotNum;
  rotationDash(this.docId, this.rotNum);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return rotationDashState(docId, this.rotNum);
  }
}

class rotationDashState extends State<rotationDash>
    with TickerProviderStateMixin {
  final docId;
  late final rotNum;

  rotationDashState(this.docId, this.rotNum);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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
        backgroundColor: LightColors.kDarkYellow,
        title: const Text(
          "Occupational Therapy  ---- Home",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 0)),
          Row(children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sessionLogs')
                        .where('logSession', isEqualTo: 'Direct')
                        .where('uid', isEqualTo: uid)
                        .where('rotation', isEqualTo: rotNum)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text(
                            "No Sessions Added",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        );
                      }
                      final documentSnapshotList = snapshot.data?.docs;
                      var results = documentSnapshotList?.length;

                      return Card(
                          margin: const EdgeInsets.all(10),
                          shadowColor: Colors.black,
                          color: LightColors.kDarkYellow,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            /* side: const BorderSide(
                                        color: Colors.black, width: 1.5), */
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>;
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.album,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                          results.toString() +
                                              " Direct Sessions",
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      // subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              )));

                      // return
                    }),
              ),
            ),
            Expanded(
              child: Container(
                width: 200,
                padding: EdgeInsets.only(top: 25),
                height: 200,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sessionLogs')
                        .where('logSession', isEqualTo: 'Indirect')
                        .where('uid', isEqualTo: uid)
                        .where('rotation', isEqualTo: rotNum)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text(
                            "No Sessions Added",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        );
                      }
                      final documentSnapshotList = snapshot.data?.docs;
                      var results = documentSnapshotList?.length;

                      return Card(
                          margin: const EdgeInsets.all(10),
                          shadowColor: Colors.black,
                          color: LightColors.kDarkYellow,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            /* side: const BorderSide(
                                        color: Colors.black, width: 1.5), */
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>;
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 25),
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.album,
                                        size: 70,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                          results.toString() +
                                              " Indirect Sessions",
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      //subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              )));
                      // return
                    }),
              ),
            ),
          ]),
          const SizedBox(height: 30.0),
          Row(children: [
            Expanded(
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                  SizedBox(height: 20.0),
                  Text('My Session Logs',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22)),
                  DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: const TabBar(
                                labelColor: LightColors.kDarkYellow,
                                unselectedLabelColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontSize: 16.0, fontFamily: 'Family Name'),
                                tabs: [
                                  Tab(text: 'Indirect'),
                                  Tab(text: 'Direct'),
                                  //Tab(text: 'Completed'),
                                  //Tab(text: 'Incomplete'),
                                ],
                              ),
                            ),
                            Container(
                                height: 400, //height of TabBarView
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.black, width: 0.5))),
                                child: TabBarView(children: <Widget>[
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            topRight: Radius.circular(90))),
                                    height: MediaQuery.of(context).size.height,
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('sessionLogs')
                                            .where('logSession',
                                                isEqualTo: 'Indirect')
                                            .where('uid', isEqualTo: uid)
                                            .where('rotation',
                                                isEqualTo: rotNum)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                streamSnapshot) {
                                          if (streamSnapshot.hasData) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: streamSnapshot
                                                    .data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  final DocumentSnapshot
                                                      documentSnapshot =
                                                      streamSnapshot
                                                          .data!.docs[index];

                                                  return Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    shadowColor: Colors.black,
                                                    //color: LightColors.kLavender,
                                                    elevation: 10,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 70,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              ListTile(
                                                                leading: CircleAvatar(
                                                                    backgroundColor:
                                                                        LightColors
                                                                            .kDarkYellow),
                                                                title: Text(
                                                                    documentSnapshot[
                                                                        'title'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16)),
                                                                subtitle: Text(
                                                                    documentSnapshot[
                                                                        'logStatus'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16)),
                                                                trailing: Icon(Icons
                                                                    .workspaces_sharp),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            topRight: Radius.circular(90))),
                                    height: MediaQuery.of(context).size.height,
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('sessionLogs')
                                            .where('logSession',
                                                isEqualTo: 'Direct')
                                            .where('uid', isEqualTo: uid)
                                            .where('rotation',
                                                isEqualTo: rotNum)
                                            .snapshots(),
                                        builder: (context,
                                            AsyncSnapshot<QuerySnapshot>
                                                streamSnapshot) {
                                          if (streamSnapshot.hasData) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: streamSnapshot
                                                    .data!.docs.length,
                                                itemBuilder: (context, index) {
                                                  final DocumentSnapshot
                                                      documentSnapshot =
                                                      streamSnapshot
                                                          .data!.docs[index];

                                                  return Card(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    shadowColor: Colors.black,
                                                    //color: LightColors.kLavender,
                                                    elevation: 10,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          height: 70,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              ListTile(
                                                                leading: const CircleAvatar(
                                                                    backgroundColor:
                                                                        LightColors
                                                                            .kDarkYellow),
                                                                title: Text(
                                                                    documentSnapshot[
                                                                        'title'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16)),
                                                                subtitle: Text(
                                                                    documentSnapshot[
                                                                        'sessionStatus'],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16)),
                                                                trailing: Icon(Icons
                                                                    .workspaces_sharp),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }),
                                  ),
                                  //  Container(
                                  // child: Center(
                                  // child: Text('Display Tab 2',
                                  //  style: TextStyle(
                                  // fontSize: 22,
                                  // fontWeight: FontWeight.bold)),
                                  //),
                                  //   ),
                                  // Container(
                                  // child: Center(
                                  //   child: Text('Display Tab 2',
                                  //  style: TextStyle(
                                  // fontSize: 22,
                                  //fontWeight: FontWeight.bold)),
                                  // ),
                                  // ),
                                ]))
                          ])),
                ])))
          ]),
        ]),
      )),
      drawer: Drawer(
        backgroundColor: Colors.white,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: LightColors.kDarkYellow,
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
                      color: Colors.black,
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
            Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: const Text('Direct Log Sessions',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
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
              color: Colors.black12,
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: const Text('Indirect Log Sessions',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
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
              color: Colors.black12,
            ),
            ListTile(
              leading: Icon(Icons.menu_book_sharp),
              title: const Text('Planner',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(rotNum),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: const Text('Tutorials',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: Icon(Icons.collections_bookmark_outlined),
              title: const Text('Outputs',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Outputs(rotNum),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: Icon(Icons.collections_bookmark_outlined),
              title: const Text('Reports',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreenReport(),
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black12,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
              },
            ),
            Divider(
              color: Colors.black12,
            ),
          ],
        ),
      ),
    );
  }
}
