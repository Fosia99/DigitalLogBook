// @dart=2.15
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:digital_logbook/LectureScreens/rotationsDashboard.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR1.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/LogSession.dart';
import 'logsHome.dart';


class MyStudents extends StatefulWidget {
  const MyStudents({Key? key}) : super(key: key);

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {

  final TextEditingController _course = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _studentNo = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _year = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference students =
  FirebaseFirestore.instance.collection('Accounts');

  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';

    if (documentSnapshot != null) {
      action = 'update';
      _course.text = documentSnapshot['course'];
      _email.text = documentSnapshot['email'];
      _firstname.text = documentSnapshot['firstname'];
      _lastname.text = documentSnapshot['lastname'];
      _studentNo.text = documentSnapshot['studentNo'];
      _type.text = documentSnapshot['type'];
      _year.text = documentSnapshot['year'];


    }


  }

  Future<void> _deleteTodo(String todoId) async {
    await students.doc(todoId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Session But why????')));
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: ColumnSuper(
            innerDistance: -30.0,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 120,
                  color: LightColors.kRed,
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 40)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CircleAvatar(
                            backgroundColor: LightColors.kLightYellow,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Text(
                            'My Students',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          CircleAvatar(
                            backgroundColor: LightColors.kLightYellow,
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90))),
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Accounts')
                        .where('type', isEqualTo: 'student')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                              return Card(
                                child: ListTile(

                                  title: Text(
                                    documentSnapshot['firstname'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    documentSnapshot['lastname'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  onTap: () {
                                    // Update the state of the app
                                    // ...
                                    // Then close the drawer
                                    var docId = documentSnapshot['uid'];
                                    Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) => rotationsDashboard(docId),
                                      ),
                                    );
                                  },
                                ),

                              );

                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      //floatingActionButton: FloatingActionButton(
       // onPressed: () => createTodo(),
        //backgroundColor: LightColors.kGreen,
        //child: const Icon(Icons.add),
      //),
    );
  }
}
