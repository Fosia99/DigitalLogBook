// @dart=2.15
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DoneTodo extends StatefulWidget {
  const DoneTodo({Key? key}) : super(key: key);

  @override
  State<DoneTodo> createState() => _DoneTodoState();
}

class _DoneTodoState extends State<DoneTodo> {
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _bodyControl = TextEditingController();
  var _typeControl = '';
  final TextEditingController _dueControl = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;


  final CollectionReference todo =
      FirebaseFirestore.instance.collection('Todo');

  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';

    if (documentSnapshot != null) {
      action = 'update';
      _titleControl.text = documentSnapshot['title'];
      _bodyControl.text = documentSnapshot['body'];
      _typeControl = documentSnapshot['type'];
      _dueControl.text = documentSnapshot['due'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              decoration: BoxDecoration(
              color: LightColors.kLightYellow,
              borderRadius: BorderRadius.circular(10),),
          padding:
          const EdgeInsets.only( left: 20.0, right: 20.0,bottom: 2),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleControl,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _bodyControl,
                  decoration: const InputDecoration(
                    labelText: 'Body',
                  ),
                ),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: _dueControl,
                  decoration: const InputDecoration(labelText: 'Due Date'),
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      labelText: "Type", border: OutlineInputBorder()),
                  value: "to do",
                  onChanged: (newValue) {
                    setState(() {
                      _typeControl = (newValue as String).toLowerCase();
                    });
                  },
                  items: ['to do', 'doing','done'].map((location) {
                    return DropdownMenuItem(
                      child: Text(location,
                          style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      value: location,
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text(action == 'add' ? 'add' : 'update'),
                    onPressed: () async {
                      final User? user = await auth.currentUser;
                      final uid = user?.uid.toString();

                      final String? title = _titleControl.text;
                      final String? body = _bodyControl.text;
                      final String? type = _typeControl;
                      final String? due = _dueControl.text;

                      if (title != null && body != null) {
                        if (action == 'add') {
                          await todo.add({
                            "uid":uid,
                            "title": title,
                            "body": body,
                            "type": type,
                            "due": due
                          });
                        }
                        if (action == 'update') {
                          await todo
                              .doc(documentSnapshot!.id)
                              .update({"title": title, "body": body});
                        }
                        _titleControl.text = '';
                        _bodyControl.text = '';
                        _typeControl = '';
                        _dueControl.text = '';


                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Planner(),
                          ),
                        );
                      }
                    })
              ]
          )
          );
        });
  }

  Future<void> _deleteTodo(String todoId) async {
    await todo.doc(todoId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Todo But why????')));
  }

  @override
  Widget build(BuildContext context) {
    final User? user =  auth.currentUser;
    final uid = user?.uid.toString();

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: ColumnSuper(
            innerDistance: -30.0,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 120,
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
                          const Icon(
                            Icons.access_time_filled_outlined,
                            color: Colors.white,
                            size: 50,
                          )
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'DONE, Good Job',
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
                    stream: FirebaseFirestore.instance
                        .collection('Todo')
                        .where('uid', isEqualTo: uid)
                        .where('type', isEqualTo: 'done')
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
                                openWithTap:
                                    true, // Open Focused-Menu on Tap rather than Long Press
                                menuOffset:
                                    10.0, // Offset value to show menuItem from the selected item
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
                                                width: 700,
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0,),
                                                height: 320,
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
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Text(
                                                        documentSnapshot[
                                                            'title'],
                                                        style: const TextStyle(
                                                            fontSize: 40,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Text(
                                                          documentSnapshot[
                                                              'body'],
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors
                                                                  .black)),
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
                                                          child: Text(
                                                              'DUE DATE : ',
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
                                                                  'due'],
                                                              style: TextStyle(
                                                                  fontSize: 20,
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
                                                                  .all(15),
                                                          child: Text(
                                                              'ACTION TYPE : ',
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
                                                                  'type'],
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )));
                                      }),
                                  FocusedMenuItem(
                                      title: Text("Edit"),
                                      trailingIcon: Icon(Icons.edit),
                                      onPressed: () {
                                        createTodo(documentSnapshot);
                                      }),
                                  FocusedMenuItem(
                                      title: Text("Continue Doing"),
                                      trailingIcon: Icon(Icons.run_circle),
                                      onPressed: () {
                                        todo
                                            .doc(documentSnapshot.id)
                                            .update({"type": 'doing'});
                                      }),
                                  FocusedMenuItem(
                                      title: const Text(
                                        "Delete",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                      trailingIcon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        _deleteTodo(documentSnapshot.id);
                                      }),
                                ],
                                onPressed: () {},

                                child: Card(
                                  margin: EdgeInsets.all(30),
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
                                          height: 220,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(
                                                  documentSnapshot['title'],
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Divider(),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                child: Text(
                                                    documentSnapshot['body'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    )),
                                              ),
                                              const Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(Icons.timelapse),
                                                  Text('Due Date'),
                                                  Text(documentSnapshot['due'])
                                                ],
                                              )
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
    );
  }
}
