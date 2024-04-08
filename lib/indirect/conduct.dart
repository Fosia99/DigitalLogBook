
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../screens/LogSession.dart';
import 'home.dart';

class IndirectConduct extends StatefulWidget {
  late final rotNum;

  IndirectConduct(this.rotNum);

  @override
  State<IndirectConduct> createState() => _IndirectConductState(rotNum);
}

class _IndirectConductState extends State<IndirectConduct> {
  late final rotNum;

  _IndirectConductState(this.rotNum);


  final TextEditingController _number = TextEditingController();
  final TextEditingController _title = TextEditingController();
  Timestamp? _date ;
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _mark_date = TextEditingController();
  var _status = '';
  var _rotation ='';
  var _duration = '';
  var _sessionType = '';
  var _supervision = '';
  var _assistive = '';
  var _logStatus = 'conduct session';


  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference indirect = FirebaseFirestore.instance.collection('sessionLogs');

  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';

    if (documentSnapshot != null) {
      action = 'update';
      _status = documentSnapshot['status'];
      _number.text = documentSnapshot['number'];
      _rotation = documentSnapshot['rotation'];
      _comments.text = documentSnapshot['comments'];
      _mark.text = documentSnapshot['mark'];
      _mark_date.text = documentSnapshot['markDate'];
      _title.text = documentSnapshot['title'];
      _startTime.text = documentSnapshot['startTime'];
      _endTime.text = documentSnapshot['endTime'];
      _date =documentSnapshot['date'];
      _duration = documentSnapshot['duration'];
      _sessionType =documentSnapshot['sessionType'];
     _supervision =documentSnapshot['supervision'];
     _assistive =documentSnapshot['assistive'];
      _logStatus =documentSnapshot['logStatus'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: LightColors.kYellow,
              leading: IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pop(context,true);
                  }
              ),

              title: Text(
                " ",
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
                color: LightColors.kLightYellow,
                borderRadius: BorderRadius.circular(10),),
              padding:
              const EdgeInsets.only( left: 10.0, right: 10.0,bottom: 10,top:20),
          child: SingleChildScrollView( child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    TextField(
                      controller: _title,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'Title',
                          labelText: 'Title',

                          labelStyle: const TextStyle(
                          color: Colors.black, //<-- SEE HERE
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'Session Number',
                          labelText: 'Session Number',
                          labelStyle: TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _startTime,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'Start Time',
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          hintText: 'End Time',
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
                      items: ['Ward Rounds', 'Supervision','Team meeting','Morning report','Work Visit','Assistive device fabrication / adaptation'].map((location) {
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
                          _supervision = (newValue as String).toLowerCase();
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
                        child: Text(action == 'add' ? 'add' : 'update'),
                        onPressed: () async {
                          final User? user = await auth.currentUser;
                          final uid = user?.uid.toString();
                          final String? status = _status;
                          final String? number = _number.text;
                          final String? rotation = _rotation;
                          final String? comments = _comments.text;
                          final String? mark = _mark.text;
                          final String? markDate = _mark_date.text;
                          final String? title = _title.text;
                          final String? startTime = _startTime.text;
                          final String? endTime = _endTime.text;
                          final Timestamp? date = _date;
                          final String? duration = _duration;
                          final String? sessionType = _sessionType;
                          final String? supervision = _supervision;
                          final String? assistive = _assistive;
                          final String? logStatus = _logStatus;

                          if (title != null) {
                            if (action == 'add') {
                              await indirect.add({
                                "uid": uid,
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
                                builder: (context) => IndirectHome(rotNum),
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

  Future<void> _deleteTodo(String todoId) async {
    await indirect.doc(todoId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Session But why????')));
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kYellow,
        leading: IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context,true);
            }
        ),

        title: const Text(
          "Conducted Indirect Sessions",
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
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('sessionLogs')
                        .where('uid', isEqualTo: uid)
                        .where('logSession', isEqualTo: 'Indirect')
                        .where('logStatus', isEqualTo: 'conduct session')
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

                              DateTime date = (documentSnapshot['date'] as Timestamp).toDate();
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
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            const Divider(),
                                            Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Text(
                                                documentSnapshot['sessionType'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            ButtonBar(
                                              alignment: MainAxisAlignment.start,
                                              children: [
                                                TextButton.icon(
                                                    icon: const Icon(
                                                      Icons.open_in_new,
                                                      size: 18.0,
                                                      color: LightColors.kYellow,
                                                    ),
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                          LightColors.kWhite,
                                                          context: context,
                                                          builder: (context) =>
                                                              Container(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                    left: 10.0,
                                                                    right: 10.0,
                                                                    bottom: 20.0,
                                                                  ),
                                                                  child:
                                                                  SingleChildScrollView(
                                                                      child:
                                                                      Column(
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
                                                                                  36,
                                                                                  color: Colors.black),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    'START TIME : ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              Container(

                                                                                child: Text(
                                                                                    documentSnapshot[
                                                                                    'startTime'],
                                                                                    style: const TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.yellow)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    ' END TIME : ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              Container(

                                                                                child: Text(
                                                                                    documentSnapshot[
                                                                                    'endTime'],
                                                                                    style: const TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.yellow)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(' DATE : ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              Text(
                                                                                  date.toString(),
                                                                                  style: const TextStyle(
                                                                                      fontSize: 20,
                                                                                      color: Colors.yellow)),
                                                                            ],
                                                                          ),
                                                                  Container(
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(),
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,

                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    'Duration: ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              Text(
                                                                                  documentSnapshot[
                                                                                  'duration'],
                                                                                  style: const TextStyle(
                                                                                      fontSize: 20,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      color: Colors.yellow)),
                                                                            ],
                                                                          ),
                                                                  ),
                                                                  Container(
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(),
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,

                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    'Session Type: ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                            Flexible(

                                                                                child: Text(
                                                                                    documentSnapshot[
                                                                                    'sessionType'],
                                                                                    style: const TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.yellow)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    'Supervision Type: ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                             Flexible(

                                                                                child: Text(
                                                                                    documentSnapshot[
                                                                                    'supervision'],
                                                                                    style: const TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.red)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    'Assistive device:',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                            Flexible(
                                                                                child: Text(
                                                                                    documentSnapshot[
                                                                                    'assistive'],
                                                                                    style: const TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.yellow)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ),

                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                            children: [
                                                                              Container(
                                                                                margin:
                                                                                const EdgeInsets.all(
                                                                                    15),
                                                                                child: const Text(
                                                                                    'Session Status: ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold)),
                                                                              ),
                                                                            Flexible(

                                                                                child: Text(
                                                                                    documentSnapshot[
                                                                                    'logStatus'],
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.yellow)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                  ),
                                                                        ],
                                                                      ))));
                                                    },
                                                    label: Text('OPEN',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black))),
                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: LightColors.kYellow,
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
                                                    color: LightColors.kYellow,
                                                    size: 18.0,
                                                  ),
                                                  onPressed: () {
                                                    indirect
                                                        .doc(documentSnapshot.id)
                                                        .update({
                                                      "logStatus": 'canceled'
                                                    });
                                                  },
                                                  label: const Text("Cancelled",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black)),
                                                ),
                                                TextButton.icon(
                                                  icon: const Icon(
                                                    Icons.delete_forever_outlined,
                                                    color: LightColors.kYellow,
                                                    size: 18.0,
                                                  ),
                                                  onPressed: () {
                                                    _deleteTodo(documentSnapshot.id);
                                                  },
                                                  label: const Text("DELETE",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.redAccent)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTodo(),
        backgroundColor: LightColors.kYellow,
        child: const Icon(Icons.add),
      ),
    );
  }
}
