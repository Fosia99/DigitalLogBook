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
  late final String fullname;
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

      String _fullname =  documentSnapshot['firstname'] +" "+ documentSnapshot['lastname'];


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


      appBar: AppBar(title: const Text("My Students",
      ),
        backgroundColor: LightColors.kDarkYellow,
          leading: IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (context) => LecturerDashboardScreen(),
                  ),
                );
              })),
      body:
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
                                  leading: Icon(Icons.star_border,size: 40,color: Colors.black,),
                                  title: Text(  "Student Name: " +
                                    _fullname.toString() ,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,fontFamily: 'Family Name'),
                                  ),
                                  subtitle: Text(  "Student Number: " +
                                    documentSnapshot['studentNo'],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,fontFamily: 'Family Name'),
                                  ),

                                  onTap: () {
                                    // Update the state of the app
                                    // ...
                                    // Then close the drawer
                                    var docId = documentSnapshot['uid'];
                                    var docName = documentSnapshot['firstname'];
                                    Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (context) => rotationsDashboard(docId,docName),
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
          );

  }
}
