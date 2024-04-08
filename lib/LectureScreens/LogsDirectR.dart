import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../screens/LogSession.dart';
import '/theme/colors/light_colors.dart';
import 'LogsIndirectR.dart';
import 'MyStudents.dart';

class studentLogsDirect extends StatefulWidget {
  static String TAG = "LogSession";

  late final  docId;
  late final rotNum;
  late final name;
  studentLogsDirect(this.docId,this.name,this.rotNum);

  @override
  _studentLogsDirectState createState() => _studentLogsDirectState(docId,name,rotNum);

}
class _studentLogsDirectState extends State<studentLogsDirect> {
  final docId;
  late final rotNum;
  late final name;
  _studentLogsDirectState(this.docId,this.name,this.rotNum);

  final TextEditingController _title = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _selectVenue = TextEditingController();
  final TextEditingController _reasonsCancel = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _mark_date = TextEditingController();

  final TextEditingController _status = TextEditingController();
  final TextEditingController _rotation = TextEditingController();
  // var _endTime ='';
  final TextEditingController _bookVenue = TextEditingController();
  final TextEditingController _clients= TextEditingController();
  final TextEditingController _sessionType = TextEditingController();
  final TextEditingController _ageGroup = TextEditingController();
  final TextEditingController _communicated = TextEditingController();
  final TextEditingController _mentalHealth = TextEditingController();
  final TextEditingController _physicalHealth = TextEditingController();
  final TextEditingController _setOutcomes = TextEditingController();
  final TextEditingController _completeSession = TextEditingController();
  final TextEditingController _submitSession= TextEditingController();
  final TextEditingController _prepareEandM = TextEditingController();
  final TextEditingController _prepareVenue = TextEditingController();
  final TextEditingController _sessionStatus = TextEditingController();
  final TextEditingController _returnedEandM = TextEditingController();
  final TextEditingController _cleanedVenue = TextEditingController();
  final TextEditingController _completeRecord = TextEditingController();
  final TextEditingController _completeReflection = TextEditingController();
 late final String fullname;

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference direct =
  FirebaseFirestore.instance.collection('direct');
  final CollectionReference markedDirect =
  FirebaseFirestore.instance.collection('markedDirect');



  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';

    final String studentName = name;

    if (documentSnapshot != null) {
      action = 'save';

      _title.text = documentSnapshot['title'];
      _status.text = documentSnapshot['status'];
      _comments.text = documentSnapshot['comments'];
      _mark.text = documentSnapshot['mark'];
      _mark_date.text = documentSnapshot['mark_date'];
      _number.text = documentSnapshot['number'];
      _rotation.text = documentSnapshot['rotation'];
      _date.text = documentSnapshot['date'];
      _startTime.text = documentSnapshot['startTime'];
      _endTime.text = documentSnapshot['endTime'];
      _selectVenue.text = documentSnapshot['selectVenue'];
      _reasonsCancel.text = documentSnapshot['reasonsCancel'];
      _bookVenue.text = documentSnapshot['bookVenue'];
      _clients.text = documentSnapshot['clients'];
      _sessionType.text = documentSnapshot['sessionType'];
      _ageGroup.text = documentSnapshot['ageGroup'];
      _communicated.text = documentSnapshot['communicated'];
      _mentalHealth.text = documentSnapshot['mentalHealth'];
      _physicalHealth.text = documentSnapshot['physicalHealth'];
      _setOutcomes.text = documentSnapshot['setOutcomes'];
      _completeSession.text = documentSnapshot['completeSession'];
      _submitSession.text = documentSnapshot['submitSession'];
      _prepareEandM.text = documentSnapshot['prepareEandM'];
      _prepareVenue.text = documentSnapshot['prepareVenue'];
      _sessionStatus.text = documentSnapshot['sessionStatus'];
      _returnedEandM.text = documentSnapshot['returnedEandM'];
      _cleanedVenue.text = documentSnapshot['cleanedVenue'];
      _completeRecord.text = documentSnapshot['completeRecord'];
      _completeReflection.text = documentSnapshot['completeReflection'];

    }
    final User? user = await auth.currentUser;
    final uid = user?.uid.toString();

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
                  studentName +" "+ "Direct Sessions",
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10),
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextField(
                                  controller: _title,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Title',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _number,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Session Number',
                                      labelStyle: TextStyle(
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
                                          fontWeight: FontWeight.bold)),
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
                                          fontWeight: FontWeight.bold)),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      print(pickedTime.format(context)); //output 10:51 PM
                                      DateTime parsedTime = DateFormat.jm()
                                          .parse(pickedTime.format(context).toString());
                                      //converting to DateTime so that we can further format on different pattern.
                                      print(parsedTime); //output 1970-01-01 22:53:00.000
                                      String formattedTime =
                                      DateFormat('HH:mm').format(parsedTime);
                                      print(formattedTime); //output 14:59:00
                                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                                      setState(() {
                                        _startTime.text =
                                            formattedTime; //set the value of text field.
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller: _endTime,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'End Time',
                                      icon: Icon(Icons.timer),
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      print(pickedTime.format(context)); //output 10:51 PM
                                      DateTime parsedTime = DateFormat.jm()
                                          .parse(pickedTime.format(context).toString());
                                      //converting to DateTime so that we can further format on different pattern.
                                      print(parsedTime); //output 1970-01-01 22:53:00.000
                                      String formattedTime =
                                      DateFormat('HH:mm').format(parsedTime);
                                      print(formattedTime); //output 14:59:00
                                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                                      setState(() {
                                        _endTime.text =
                                            formattedTime; //set the value of text field.
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                ),
                                const SizedBox(height: 30),
                                TextField(
                                  controller:_rotation,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Clinical Rotation Number',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:_selectVenue,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Selected venue',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),

                                const SizedBox(height: 20),
                                TextField(
                                  controller: _bookVenue,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Booked venue',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),


                                TextField(
                                  controller:   _clients,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Identifed client(s)',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                TextField(
                                  controller:   _sessionType,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Session Type',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),

                                TextField(
                                  controller:    _ageGroup,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Age group of Erickson',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),

                                TextField(
                                  controller:  _communicated,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Communicate with stakeholders',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),

                                TextField(
                                  controller:  _physicalHealth,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Physical Health diagnoses',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:  _mentalHealth,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Mental Health diagnoses ',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:   _setOutcomes ,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Set session outcomes ',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:  _completeSession,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Completed session plan',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:    _prepareEandM,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Prepared Equipment and materials',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:  _prepareVenue,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Prepared venue ',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller:  _sessionStatus,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Session Status',
                                      labelStyle: const TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _reasonsCancel,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Reasons for Cancelling',
                                      labelStyle: TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20.0),
                                TextField(
                                  controller: _returnedEandM,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Returned material / equipment used',
                                      labelStyle: TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _cleanedVenue,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Cleaned venue',
                                      labelStyle: TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),

                                const SizedBox(height: 20.0),

                                TextField(
                                  controller:   _completeSession,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Completed record keeping',
                                      labelStyle: TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 20.0),

                                TextField(
                                  controller: _completeReflection,
                                  enabled: false,
                                  decoration: const InputDecoration(
                                      labelText: 'Completed reflection',
                                      labelStyle: TextStyle(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 30.0),
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
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                                      labelStyle:  TextStyle(
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
                                      labelStyle:  TextStyle(
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
                                    child: Text(action == 'add' ? 'add' : 'save',
                                        style: const TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 16,
                                          //backgroundColor: LightColors.kRed,
                                          color: Colors.black,
                                        )),
                                    onPressed: () async {
                                      final User? user = await auth.currentUser;
                                      final uid = user?.uid.toString();

                                      final String? status = _status.text;
                                      final String? comments = _comments.text;
                                      final String? mark = _mark.text;
                                      final String? markDate = _mark_date.text;
                                      final String? title = _title.text;
                                      final String? number = _number.text;
                                      final String? rotation = _rotation.text;
                                      final String? startTime = _startTime.text;
                                      final String? endTime = _endTime.text;
                                      final String? date = _date.text;
                                      final String? reasonsCancel = _reasonsCancel.text;
                                      final String? selectVenue = _selectVenue.text;
                                      final String? bookVenue = _bookVenue.text;
                                      final String? clients = _clients.text;
                                      final String? sessionType = _sessionType.text;
                                      final String? ageGroup = _ageGroup.text;
                                      final String? communicated = _communicated.text;
                                      final String? mentalHealth = _mentalHealth.text;
                                      final String? physicalHealth = _physicalHealth.text;
                                      final String? setOutcomes = _setOutcomes.text;
                                      final String? completeSession = _completeSession.text;
                                      final String? submitSession = _submitSession.text;
                                      final String? prepareEandM = _prepareEandM.text;
                                      final String? prepareVenue = _prepareVenue.text;
                                      final String? sessionStatus = _sessionStatus.text;
                                      final String? returnedEandM = _returnedEandM.text;
                                      final String? cleanedVenue = _cleanedVenue.text;
                                      final String? completeRecord = _completeRecord.text;
                                      final String? completeReflection = _completeReflection.text;

                                      if (title != null) {
                                        if (action == 'add') {
                                          await direct.add({
                                            "uid": uid,
                                            "title": title,
                                            "number": number,
                                            "rotation": rotation,
                                            "startTime": startTime,
                                            "endTime": endTime,
                                            "date": date,
                                            "selectVenue": selectVenue,
                                            "reasonsCancel": reasonsCancel,
                                            "bookVenue": bookVenue,
                                            "clients": clients,
                                            "sessionType": sessionType,
                                            "ageGroup": ageGroup,
                                            "communicated": communicated,
                                            "mentalHealth": mentalHealth,
                                            "physicalHealth": physicalHealth,
                                            "setOutcomes": setOutcomes,
                                            "completeSession": completeSession,
                                            "submitSession": submitSession,
                                            "prepareEandM": prepareEandM,
                                            "prepareVenue": prepareVenue,
                                            "sessionStatus": sessionStatus,
                                            "returnedEandM": returnedEandM,
                                            "cleanedVenue": cleanedVenue,
                                            "completeRecord": completeRecord,
                                            "completeReflection": completeReflection,
                                            "status": status,
                                            "comments": comments,
                                            "mark": mark,
                                            "markDate": markDate,
                                          });
                                        }
                                        if (action == 'save') {
                                          await direct.doc(documentSnapshot!.id).update({
                                            "title": title,
                                            "number": number,
                                            "rotation": rotation,
                                            "startTime": startTime,
                                            "endTime": endTime,
                                            "date": date,
                                            "selectVenue": selectVenue,
                                            "reasonsCancel": reasonsCancel,
                                            "bookVenue": bookVenue,
                                            "clients": clients,
                                            "sessionType": sessionType,
                                            "ageGroup": ageGroup,
                                            "communicated": communicated,
                                            "mentalHealth": mentalHealth,
                                            "physicalHealth": physicalHealth,
                                            "setOutcomes": setOutcomes,
                                            "completeSession": completeSession,
                                            "submitSession": submitSession,
                                            "prepareEandM": prepareEandM,
                                            "prepareVenue": prepareVenue,
                                            "sessionStatus": sessionStatus,
                                            "returnedEandM": returnedEandM,
                                            "cleanedVenue": cleanedVenue,
                                            "completeRecord": completeRecord,
                                            "completeReflection": completeReflection,
                                            "status": status,
                                            "comments": comments,
                                            "mark": mark,
                                            "markDate": markDate,
                                          });
                                        }
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => studentLogsDirect(docId,name,rotNum),
                                          ),
                                        );
                                      }
                                    })
                              ])))));
        });
  }


  @override
  Widget build(BuildContext context) {

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
                          .collection('direct')
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
                                                  documentSnapshot['sessionType'],
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
              ]),
            ),
          ),
        );
  }
}
