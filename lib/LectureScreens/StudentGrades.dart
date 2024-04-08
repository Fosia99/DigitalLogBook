// @dart=2.15
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:digital_logbook/LectureScreens/LogsDashboard.dart';
import 'package:digital_logbook/LectureScreens/LogsDirectR.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/LogSession.dart';
import 'GradesDashboard.dart';
import 'LecturerDashboardScreen.dart';



class StudentsGrades extends StatefulWidget {
  const StudentsGrades({Key? key}) : super(key: key);

  @override
  State<StudentsGrades> createState() => _StudentsGradesState();
}

class _StudentsGradesState extends State<StudentsGrades> {

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


  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();




    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){

            Navigator.pushReplacement(context,
            MaterialPageRoute(
            builder: (context) => LecturerDashboardScreen(),
            ),
            );

            }
        ),
        backgroundColor: LightColors.kDarkYellow,
        title: const Text("My Students", style: TextStyle(color: Colors.black,)

          ,),
        actions: [
          //IconButton(icon: Icon(Icons.search, color: Colors.grey,), onPressed: () {}),

        ],

      ),
      body: Container(
        child: SingleChildScrollView(
          child: ColumnSuper(
            innerDistance: -30.0,
            children: [
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
                              String _fullname =  documentSnapshot['firstname'] +" "+ documentSnapshot['lastname'];
                              return Card(
                                child: ListTile(
                                  leading: const CircleAvatar(
                                      backgroundColor:
                                      LightColors
                                          .kLightRed),
                                  title: Text("Student Name: " +
                                _fullname.toString(),
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text( "Student Number: " +
                                    documentSnapshot['studentNo'],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  onTap: () {
                                    // Update the state of the app
                                    // ...
                                    // Then close the drawer
                                    var docId = documentSnapshot['uid'];
                                    var docName = documentSnapshot['firstname'];
                                    Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) => GradesDashboard(docId,docName),
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
