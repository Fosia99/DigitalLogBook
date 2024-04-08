// @dart=2.15
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import '/widgets/back_button.dart';

class DoingTodo extends StatefulWidget {
  const DoingTodo({Key? key}) : super(key: key);

  @override
  State<DoingTodo> createState() => _DoingTodoState();
}

class _DoingTodoState extends State<DoingTodo> {
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
  Widget build(BuildContext context)  {
    final User? user =  auth.currentUser;
    final uid = user?.uid.toString();
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  LightColors.kGreen,
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),

        title: Text(
          "DOING",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          //IconButton(icon: Icon(Icons.search, color: Colors.grey,), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child:  Container(


                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90))),
                height: MediaQuery.of(context).size.height / 1.5,

                child: StreamBuilder(

                    stream:
                    FirebaseFirestore.instance
                        .collection('Todo')
                        .where('uid', isEqualTo: uid)
                        .where('type', isEqualTo: 'doing')
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
                                clipBehavior: Clip.antiAlias,
                                elevation: 8,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 150,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                documentSnapshot['title'],
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            const Divider(),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Text(
                                                documentSnapshot['body'],
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6)),
                                              ),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.start,
                                              children: [
                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.open_in_new,
                                                    size: 18.0,
                                                  ),

                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                        LightColors.kLightGreen,
                                                        context: context,
                                                        builder: (context) =>
                                                            Container(
                                                                width: 700,
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                  left: 10.0,
                                                                  right: 10.0,
                                                                ),
                                                                height: 320,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                          180),
                                                                      child:
                                                                      const Icon(
                                                                        Icons
                                                                            .horizontal_rule,
                                                                        size: 50,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin:
                                                                      const EdgeInsets
                                                                          .all(15),
                                                                      child: Text(
                                                                        documentSnapshot[
                                                                        'title'],
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                            40,
                                                                            color: Colors
                                                                                .black),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin:
                                                                      const EdgeInsets
                                                                          .all(15),
                                                                      child: Text(
                                                                          documentSnapshot[
                                                                          'body'],
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              20,
                                                                              color:
                                                                              Colors.black)),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                      children: [
                                                                        Container(
                                                                          margin:
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                          child: Text(
                                                                              'DUE DATE : ',
                                                                              style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        Container(
                                                                          margin:
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                          child: Text(
                                                                              documentSnapshot[
                                                                              'due'],
                                                                              style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  color: Colors.black)),
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
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                          child: Text(
                                                                              'ACTION TYPE : ',
                                                                              style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  color: Colors.black,
                                                                                  fontWeight: FontWeight.bold)),
                                                                        ),
                                                                        Container(
                                                                          margin:
                                                                          const EdgeInsets.all(
                                                                              15),
                                                                          child: Text(
                                                                              documentSnapshot[
                                                                              'type'],
                                                                              style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.black)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )));
                                                  },
                                                  label: Text('OPEN',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ),
                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    size: 18.0,
                                                  ),
                                                  onPressed: () {
                                                    createTodo(documentSnapshot);
                                                  },
                                                  label: Text('EDIT',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ),
                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.run_circle_outlined,
                                                    size: 18.0,
                                                  ),

                                                  onPressed: () {
                                                    todo
                                                        .doc(documentSnapshot.id)
                                                        .update({"type": 'done'});
                                                  },
                                                  label: const Text("DONE",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ),
                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.delete_forever_outlined,
                                                    size: 18.0,
                                                  ),


                                                  onPressed: () {
                                                    _deleteTodo(
                                                        documentSnapshot.id);
                                                  },
                                                  label: const Text("DELETE",
                                                      style: TextStyle(
                                                          fontSize: 12,

                                                          color: Colors.black)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
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
      ),
    );
  }
}
