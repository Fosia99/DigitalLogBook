// @dart=2.15
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/LogSession.dart';


class MySupStudents extends StatefulWidget {
  const MySupStudents({Key? key}) : super(key: key);

  @override
  State<MySupStudents> createState() => _MySupStudentsState();
}

class _MySupStudentsState extends State<MySupStudents> {

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

                              return FocusedMenuHolder(
                                menuWidth:
                                MediaQuery.of(context).size.width * 0.50,
                                blurSize: 5.0,
                                menuItemExtent: 45,
                                menuBoxDecoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                duration: const Duration(milliseconds: 100),
                                animateMenuItems: true,
                                blurBackgroundColor: Colors.black54,
                                openWithTap: true,
                                // Open Focused-Menu on Tap rather than Long Press
                                menuOffset: 10.0,
                                // Offset value to show menuItem from the selected item
                                bottomOffsetHeight: 80.0,

                                menuItems: [
                                  FocusedMenuItem(
                                      title: const Text("Open"),
                                      trailingIcon: const Icon(Icons.open_in_new),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: LightColors.kLightGreen,
                                            context: context,
                                            builder: (context) => Container(
                                                width: MediaQuery.of(context).size.width,
                                                padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0,),
                                                height: MediaQuery.of(context).size.height,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 180),
                                                      child: const Icon(
                                                        Icons.horizontal_rule,
                                                        size: 50,
                                                      ),

                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          margin:
                                                          const EdgeInsets
                                                              .all(15),
                                                          child: const Text(
                                                              ' Name : ',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                        ),
                                                        Container(
                                                          margin:
                                                          const EdgeInsets
                                                              .all(15),
                                                          child: Text(
                                                              documentSnapshot[
                                                              'firstname'],
                                                              style:const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )));
                                      }),

                                ],
                                onPressed: () {},

                                child: Card(
                                  margin: EdgeInsets.all(5),
                                  shadowColor: Colors.black,
                                  color: Color.fromARGB(255, 215, 242, 255),
                                  shape: RoundedRectangleBorder(
                                    /* side: const BorderSide(
                                        color: Colors.black, width: 1.5), */
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(top:25),
                                          height: 95,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .all(5),
                                                    child: const Text(
                                                        ' Name : ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)),
                                                  ),
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .all(5),
                                                    child: Text(
                                                        documentSnapshot[
                                                        'firstname'],
                                                        style:const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .black)),
                                                  ),
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .all(5),
                                                    child: Text(
                                                        documentSnapshot[
                                                        'lastname'],
                                                        style:const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .black)),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .all(5),
                                                    child: const Text(
                                                        ' Year : ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)),
                                                  ),
                                                  Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .all(5),
                                                    child: Text(
                                                        documentSnapshot[
                                                        'year'],
                                                        style:const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .black)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
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
