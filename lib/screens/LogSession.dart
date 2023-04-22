import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/AppConfig.dart';
import 'CommonWidget/getCommonWidget.dart';
import '/screens/calendar_page.dart';
import '/screens/create_seassion_direct_form.dart';
import '/screens/create_seassion_indirect_form.dart';
import '/theme/colors/light_colors.dart';
import '/widgets/active_project_card.dart';
import '/widgets/task_column.dart';
import '/screens/doctorData.dart';
import '/indirect/conduct.dart';

class LogSession extends StatefulWidget {
  static String TAG = "LogSession";

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  _LogSessionState createState() => _LogSessionState();
}

CircleAvatar calendarIcon() {
  return CircleAvatar(
    radius: 25.0,
    backgroundColor: LightColors.kGreen,
    child: Icon(
      Icons.add,
      size: 20.0,
      color: Colors.white,
    ),
  );
}

class _LogSessionState extends State<LogSession> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Sessions Plans",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () {}),
              ],
              bottom: const TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
              Direct(),
              InDirect(),
            ]),
          )),
    );
  }
}

class Direct extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    return Scaffold(
      backgroundColor: LightColors.kLightGreen,
      body: Container(
        child: SingleChildScrollView(
          child: ColumnSuper(innerDistance: -30.0, children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 80,
                color: LightColors.kGreen,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [],
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: const Text(
                          'Your Direct Session Logs',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))
                  ],
                )),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      topRight: Radius.circular(90))),
              height: MediaQuery.of(context).size.height / 1.5,
              child: StreamBuilder(
                  stream: db
                      .collection('DirectSessionLogs')
                      .where('userId', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot doc =
                                snapshot.data!.docs[index];

                            return Card(
                              child: ListTile(
                                title: Text(
                                  doc['title'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  doc['sessionType'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNewSessionDirect(),
            ),
          );
        },
        backgroundColor: LightColors.kGreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InDirect extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: Container(
        child: SingleChildScrollView(
          child: ColumnSuper(innerDistance: -30.0, children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 80,
                color: LightColors.kDarkYellow,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [],
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: const Text(
                          'Your Indirect Session Logs',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))
                  ],
                )),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      topRight: Radius.circular(90))),
              height: MediaQuery.of(context).size.height / 1.5,
              child: StreamBuilder(
                  stream: db
                      .collection('IndirectSessionLogs')
                      .where('userId', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot doc =
                            snapshot.data!.docs[index];

                            return Card(
                              child: ListTile(
                                title: Text(
                                  doc['title'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  doc['sessionType'],
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ]),
        ),
      ),

    );
  }
}