import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../MyStudents.dart';
import '/theme/colors/light_colors.dart';




class LogsDirectR2 extends StatefulWidget {
  static String TAG = "LogSession";

  late final  docId;
  LogsDirectR2(this.docId);


  @override
  _LogsDirectR2State createState() => _LogsDirectR2State(docId);

}
class _LogsDirectR2State extends State<LogsDirectR2> {
  final docId;
  _LogsDirectR2State(this.docId);

  final TextEditingController _mark = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _mark_date = TextEditingController();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();

  var _status = '';
  var _duration = '';
  var _sessionType = '';
  var _Supervision = '';
  var _assistive = '';
  var _logStatus = '';

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference indirect =
  FirebaseFirestore.instance.collection('Indirect');
  final CollectionReference markedIndirect =
  FirebaseFirestore.instance.collection('markedIndirect');



  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'save';


    if (documentSnapshot != null) {
      action = 'save';
      _status = documentSnapshot['status'];
      _comments.text = documentSnapshot['comments'];
      _mark.text = documentSnapshot['mark'];
      _mark_date.text = documentSnapshot['mark_date'];

      _title.text = documentSnapshot['title'];
      _startTime.text = documentSnapshot['startTime'];
      _endTime.text = documentSnapshot['endTime'];
      _date.text = documentSnapshot['date'];
      _duration = documentSnapshot['duration'];
      _sessionType = documentSnapshot['sessionType'];
      _Supervision = documentSnapshot['supervision'];
      _assistive = documentSnapshot['assistive'];
      _logStatus = documentSnapshot['logStatus'];
    }
    final User? user = await auth.currentUser;
    final uid = user?.uid.toString();

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              decoration: BoxDecoration(
                color: LightColors.kLightYellow,
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
              const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 2),
              child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Indirect')
                          .where('uid', isEqualTo: docId)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];

                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 180),
                                        child: const Icon(
                                          Icons.horizontal_rule,
                                          size: 50,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(15),
                                        child: Text(
                                          documentSnapshot['title'],
                                          style: const TextStyle(fontSize: 40, color: Colors.black),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: const Text('START TIME : ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: Text(
                                                documentSnapshot['startTime'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: const Text(' END TIME : ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: Text(
                                                documentSnapshot['endTime'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: const Text(' DATE : ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: Text(
                                                documentSnapshot['date'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: const Text('DURATION: ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: Text(
                                                documentSnapshot['duration'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: const Text('SESSION TYPE: ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(5),
                                            child: Text(
                                                documentSnapshot['sessionType'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: const Text(
                                                'SUPERVISION TYPE: ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: Text(
                                                documentSnapshot['supervision'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: const Text(
                                                'Assistive device fabrication / adaptation: ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(15),
                                            child: Text(
                                                documentSnapshot['assistive'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(15),
                                              child: const Text(
                                                  'Session Status: ',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(15),
                                              child: Text(
                                                  documentSnapshot[
                                                  'logStatus'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: Colors.black)),
                                            ),
                                            DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                  labelText: "Status",
                                                  border: OutlineInputBorder(),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      //<-- SEE HERE
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                              value: "Marked",
                                              onChanged: (newValue) {
                                                setState(() {
                                                  _status = (newValue as String)
                                                      .toLowerCase();
                                                });
                                              },
                                              items: ['Marked', 'Incomplete']
                                                  .map((location) {
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
                                            TextField(
                                              controller: _mark,
                                              decoration: const InputDecoration(
                                                  labelText: 'Mark',
                                                  labelStyle: const TextStyle(
                                                      color: Colors.black,
                                                      //<-- SEE HERE
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                            TextField(
                                              controller: _comments,
                                              decoration: const InputDecoration(
                                                  labelText: 'Comments',
                                                  labelStyle:  TextStyle(
                                                      color: Colors.black,
                                                      //<-- SEE HERE
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                            const SizedBox(height: 15),
                                            TextField(
                                              controller: _mark_date,
                                              decoration: const InputDecoration(
                                                  labelText: 'Date Marked',
                                                  icon: Icon(
                                                      Icons.calendar_today),
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      //<-- SEE HERE
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                              readOnly: true,
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                    DateTime.now(),
                                                    firstDate:
                                                    DateTime(2020),
                                                    //DateTime.now() - not to allow to choose before today.
                                                    lastDate:
                                                    DateTime(2100));

                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  setState(() {
                                                    _date.text =
                                                        formattedDate; //set output date to TextField value.
                                                  });
                                                } else {}
                                              },
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                child: Text(action == 'add' ? 'add' : 'save'),
                                                onPressed: () async {
                                                  final User? user = await auth.currentUser;
                                                  final uid = user?.uid.toString();

                                                  final String? status = _status;
                                                  final String? comments = _comments.text;
                                                  final String? mark = _mark.text;
                                                  final String? markDate = _mark_date.text;
                                                  final String? title = _title.text;
                                                  final String? startTime = _startTime.text;
                                                  final String? endTime = _endTime.text;
                                                  final String? date = _date.text;
                                                  final String? duration = _duration;
                                                  final String? sessionType = _sessionType;
                                                  final String? supervision = _Supervision;
                                                  final String? assistive = _assistive;
                                                  final String? logStatus = _logStatus;

                                                  if (title != null) {
                                                    if (action == 'save') {
                                                      await indirect
                                                          .doc(documentSnapshot.id)
                                                          .update({
                                                        "title": title,
                                                        "startTime": startTime,
                                                        "endTime": endTime,
                                                        "date": date,
                                                        "duration": duration,
                                                        "sessionType": sessionType,
                                                        "supervision": supervision,
                                                        "assistive": assistive,
                                                        "logStatus": logStatus,
                                                        "status": status,
                                                        "comments": comments,
                                                        "mark": mark,
                                                        "markDate": markDate,
                                                      });
                                                    }

                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyStudents(),
                                                      ),
                                                    );
                                                  }
                                                })
                                          ])
                                    ]);
                              });
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                        ;
                      })));
        });
  }


  @override
  Widget build(BuildContext context) {


    // final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    return MaterialApp(
        debugShowCheckedModeBanner: false,



        home: Scaffold(
          backgroundColor: LightColors.kLightYellow,
          body: Container(
            child: SingleChildScrollView(
              child: ColumnSuper(innerDistance: -30.0, children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 80,
                    //color: LightColors.kDarkYellow,
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 5)),
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
                          .collection('Indirect')
                          .where('uid', isEqualTo: docId)
                          .snapshots(),
                      builder:  (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();

                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];

                                return Card(
                                  child: ListTile(
                                    title: Text(
                                      documentSnapshot['title'],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      documentSnapshot['sessionType'],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: ()  {
                                      createTodo(documentSnapshot);
                                    },
                                  ),
                                );
                              });
                        }
                      }),
                ),
              ]),
            ),
          ),

        ));

  }
}
