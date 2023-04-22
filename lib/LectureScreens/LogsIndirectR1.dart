

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import '../indirect/home.dart';
import '../screens/LogSession.dart';
import '/theme/colors/light_colors.dart';
import 'MyStudents.dart';

class studentLogsIndirect extends StatefulWidget {
  static String TAG = "LogSession";

  late final  docId;
  studentLogsIndirect(this.docId);


  @override
  _studentLogsIndirectState createState() => _studentLogsIndirectState(docId);
  //_IndirectState create() => _IndirectState(docId);

}



class _studentLogsIndirectState extends State<studentLogsIndirect> {
  final docId;
  _studentLogsIndirectState(this.docId);

  final TextEditingController _title = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _mark_date = TextEditingController();
  final TextEditingController _number = TextEditingController();
  var _rotation ='';
  var _status = '';
  var _duration = '';
  //late DateTime _date;
  var _sessionType = '';
  var _Supervision = '';
  var _assistive = '';
  var _logStatus = '';
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference indirect =
  FirebaseFirestore.instance.collection('Indirect');

  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';

    if (documentSnapshot != null) {
      action = 'update';
      _status = documentSnapshot['status'];
      _number.text = documentSnapshot['number'];
      _rotation = documentSnapshot['rotation'];
      _comments.text = documentSnapshot['comments'];
      _mark.text = documentSnapshot['mark'];
      _mark_date.text = documentSnapshot['mark_date'];
      _title.text = documentSnapshot['title'];
      _startTime.text = documentSnapshot['startTime'];
      _endTime.text = documentSnapshot['endTime'];
      _date.text =documentSnapshot['date'];
      _duration = documentSnapshot['duration'];
      _sessionType =documentSnapshot['sessionType'];
      _Supervision =documentSnapshot['supervision'];
      _assistive =documentSnapshot['assistive'];
      _logStatus =documentSnapshot['logStatus'];
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
            child: SingleChildScrollView( child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  TextField(
                    controller: _title,
                    decoration: const InputDecoration(labelText: 'Title',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _number,
                    decoration: const InputDecoration(
                        labelText: 'Session Number',
                        labelStyle: TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Clinical Rotation Number",
                        border: OutlineInputBorder(),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    value: "1",
                    onChanged: (newValue) {
                      setState(() {
                        _rotation = (newValue as String).toLowerCase();
                      });
                    },
                    items: ['1', '2','3','4'].map((location) {
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
                  const SizedBox(height: 20),

                  TextField(
                    controller: _date,
                    decoration: const InputDecoration(
                        labelText: 'Date',
                        icon: Icon(Icons.calendar_today),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          _date.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),

                  const SizedBox(height: 30),
                  TextField(
                    controller: _startTime,
                    decoration: const InputDecoration(
                        labelText: 'Start Time',
                        icon: Icon(Icons.timer),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime =  await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if(pickedTime != null ){
                        print(pickedTime.format(context));   //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime = DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          _startTime.text = formattedTime; //set the value of text field.
                        });
                      }else{
                        print("Time is not selected");
                      }
                    },
                  ),

                  const SizedBox(height:30 ),
                  TextField(
                    controller: _endTime,
                    decoration: const InputDecoration(
                        labelText: 'End Time',
                        icon: Icon(Icons.timer),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime =  await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if(pickedTime != null ){
                        print(pickedTime.format(context));   //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime = DateFormat('HH:mm').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          _endTime.text = formattedTime; //set the value of text field.
                        });
                      }else{
                        print("Time is not selected");
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Duration", border: OutlineInputBorder(),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    value: "0:30",
                    onChanged: (newValue) {
                      setState(() {
                        _duration = (newValue as String).toLowerCase();
                      });
                    },
                    items: ['0:30', '1:30','2:00'].map((location) {
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
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Session Type", border: OutlineInputBorder(),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    value: "Ward Rounds",
                    onChanged: (newValue) {
                      setState(() {
                        _sessionType = (newValue as String).toLowerCase();
                      });
                    },
                    items: ['Ward Rounds', 'Supervision','Team meeting','Morning report','Work Visit','Assistive device fabrication / adaptation:'].map((location) {
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
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Supervision Type", border: OutlineInputBorder(),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    value: "Case Supervisor",
                    onChanged: (newValue) {
                      setState(() {
                        _Supervision = (newValue as String).toLowerCase();
                      });
                    },
                    items: ['Case Supervisor', 'Clinical Supervisor','Academic Supervisor'].map((location) {
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
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Assistive device fabrication/adaptation Type", border: OutlineInputBorder(),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    value: "Wheelchair",
                    onChanged: (newValue) {
                      setState(() {
                        _assistive = (newValue as String).toLowerCase();
                      });
                    },
                    items: ['Wheelchair', 'Splint','Corner seat','Routine chart','Medication tracker','Communication Charts','Other'].map((location) {
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
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                        labelText: "Log Session Status", border: OutlineInputBorder(),
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    value: "Conduct session",
                    onChanged: (newValue) {
                      setState(() {
                        _logStatus = (newValue as String).toLowerCase();
                      });
                    },
                    items: ['Conduct session', 'Canceled','Postponed'].map((location) {
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _comments,
                    decoration: const InputDecoration(
                        labelText: 'Comments',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
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
                  ElevatedButton(
                      child: Text(action == 'add' ? 'add' : 'update'),
                      onPressed: () async {
                        final User? user = await auth.currentUser;
                        final uid = user?.uid.toString();

                        final String? status = _status;
                        final String? comments = _comments.text;
                        final String? mark = _mark.text;
                        final String? markDate = _mark_date.text;
                        final String? number = _number.text;
                        final String? rotation = _rotation;
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
                          if (action == 'add') {
                            await indirect.add({
                              "uid": uid,
                              "number": number,
                              "rotation": rotation,
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
                          if (action == 'update') {
                            await indirect
                                .doc(documentSnapshot!.id)
                                .update({
                              "title": title,
                              "number": number,
                              "rotation": rotation,
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
                              "markDate": markDate,});
                          }

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => studentLogsIndirect(docId),
                            ),
                          );
                        }
                      })
                ]
            )
            ),
          );
        });
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
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90))),
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Indirect')
                        .where('uid', isEqualTo: docId)
                        .where('rotation', isEqualTo: '1')
                    // .orderBy('date')
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
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 0.50,
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
                                      title: Text("Edit"),

                                      trailingIcon: Icon(Icons.edit),
                                      onPressed: () {
                                        createTodo(documentSnapshot);
                                      }),

                                ],
                                onPressed: () {},

                                child: Card(
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
