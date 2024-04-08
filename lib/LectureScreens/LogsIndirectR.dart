

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late final rotNum;
  late final name;
  studentLogsIndirect(this.docId,this.name,this.rotNum);


  @override
  _studentLogsIndirectState createState() => _studentLogsIndirectState(docId,name,rotNum);
  //_IndirectState create() => _IndirectState(docId);

}



class _studentLogsIndirectState extends State<studentLogsIndirect> {
  final docId;
  late final rotNum;
  late final name;
  _studentLogsIndirectState(this.docId,this.name,this.rotNum);

  final TextEditingController _title = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _mark_date = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _rotation =TextEditingController();
  final TextEditingController _status =TextEditingController();
  final TextEditingController _duration=TextEditingController();
  //late DateTime _date;
  final TextEditingController _sessionType =TextEditingController();
  final TextEditingController _Supervision =TextEditingController();
  final TextEditingController _assistive =TextEditingController();
  final TextEditingController _logStatus =TextEditingController();


  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference indirect =
  FirebaseFirestore.instance.collection('Indirect');

  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';
    final String studentName = name;
    if (documentSnapshot != null) {
      action = 'save';
      _status.text = documentSnapshot['status'];
      _number.text = documentSnapshot['number'];
      _rotation.text = documentSnapshot['rotation'];
      _comments.text = documentSnapshot['comments'];
      _mark.text = documentSnapshot['mark'];
      _mark_date.text = documentSnapshot['mark_date'];
      _title.text = documentSnapshot['title'];
      _startTime.text = documentSnapshot['startTime'];
      _endTime.text = documentSnapshot['endTime'];
      _date.text =documentSnapshot['date'];
      _duration.text = documentSnapshot['duration'];
      _sessionType.text =documentSnapshot['sessionType'];
      _Supervision.text =documentSnapshot['supervision'];
      _assistive.text =documentSnapshot['assistive'];
      _logStatus.text =documentSnapshot['logStatus'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
            return Scaffold(
            appBar: AppBar(
              backgroundColor: LightColors.kDarkYellow,
              leading: IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pop(context,true);
                  }
              ),

              title: Text(
                studentName  +" "+ "Indirect Sessions",
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),),
              padding: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10),
            child: SingleChildScrollView( child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  TextField(
                    enabled: false,
                    controller: _title,
                    decoration: const InputDecoration(labelText: 'Title',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    enabled: false,
                    controller: _number,
                    decoration: const InputDecoration(
                        labelText: 'Session Number',
                        labelStyle: TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    enabled: false,
                    controller: _rotation,
                    decoration: const InputDecoration(labelText: 'Clinical Rotation Number',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _date,
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                  TextField(
                    enabled: false,
                    controller: _duration ,
                    decoration: const InputDecoration(labelText: 'Duration',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    enabled: false,
                    controller:  _sessionType ,
                    decoration: const InputDecoration(labelText: 'Session Type',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    enabled: false,
                    controller:    _Supervision ,
                    decoration: const InputDecoration(labelText: 'Supervision Type',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    enabled: false,
                    controller:  _logStatus ,
                    decoration: const InputDecoration(labelText: 'Log Session Status',
                        labelStyle: const TextStyle(
                            color: Colors.black, //<-- SEE HERE
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
                        _status.text = (newValue as String)
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
                  TextFormField(
                    controller: _mark,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                      TextInputFormatter.withFunction(
                            (oldValue, newValue) => newValue.copyWith(
                          text: newValue.text.replaceAll('.', ','),
                        ),
                      ),
                    ],
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
                          _mark_date.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          LightColors.kDarkYellow,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(action == 'add' ? 'add' : 'save'),
                      onPressed: () async {
                        final User? user = await auth.currentUser;
                        final uid = user?.uid.toString();

                        final String? status = _status.text;
                        final String? comments = _comments.text;
                        final String? mark = _mark.text;
                        final String? markDate = _mark_date.text;
                        final String? number = _number.text;
                        final String? rotation = _rotation.text;
                        final String? title = _title.text;
                        final String? startTime = _startTime.text;
                        final String? endTime = _endTime.text;
                        final String? date = _date.text;
                        final String? duration = _duration.text;
                        final String? sessionType = _sessionType.text;
                        final String? supervision = _Supervision.text;
                        final String? assistive = _assistive.text;
                        final String? logStatus = _logStatus.text;

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
                          if (action == 'save') {
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
                              builder: (context) => studentLogsIndirect(docId,name,rotNum),
                            ),
                          );
                        }
                      })
                ]
            )
            ),
          )));
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
                decoration: BoxDecoration(
                  color: LightColors.kLightYellow,
                  borderRadius: BorderRadius.circular(10),),

                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Indirect')
                        .where('uid', isEqualTo: docId)
                        .where('rotation', isEqualTo: rotNum)
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

                              return Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 8,
                                child: Column(
                                  children: [
                                    Container(
                                        height: 120,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              child: Text(
                                                documentSnapshot['title'],
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,fontFamily: 'Family Name'),
                                              ),
                                            ),
                                            const Divider(),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                documentSnapshot['logStatus'],
                                                style: TextStyle(
                                                    color: Colors.black
                                                       ,fontWeight: FontWeight.bold,fontFamily: 'Family Name'),
                                              ),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.start,
                                              children: [

                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    size: 18.0,
                                                  ),
                                                  onPressed: () {
                                                    createTodo(documentSnapshot);
                                                  },
                                                  label: const Text('EVALUATE',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Family Name')),
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
            ],
          ),
        ),
      ),

    );
  }
}

class _getRegexString {
}
