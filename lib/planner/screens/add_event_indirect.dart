import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/colors/light_colors.dart';

class AddEventIndirect extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;

  const AddEventIndirect(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEventIndirect> createState() => _AddEventState();
}

class _AddEventState extends State<AddEventIndirect> {
  late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  final TextEditingController _comments = TextEditingController();
  final TextEditingController _mark_date = TextEditingController();

  var _status = '';
  var _rotation = '';
  var _duration = '';
  var _sessionType = '';
  var _Supervision = '';
  var _assistive = '';
  var _logStatus = 'conduct session';
  Duration duration = Duration(hours: 0, minutes: 0);

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Indirect Session"),
        backgroundColor: LightColors.kDarkYellow,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InputDatePickerFormField(
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _selectedDate,
            onDateSubmitted: (date) {
              print(date);
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: 'Title',
                labelText: 'Title',
                labelStyle: TextStyle(
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
                labelStyle: TextStyle(
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
                String formattedTime = DateFormat('HH:mm').format(parsedTime);
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
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: 'End Time',
                labelText: 'End Time',
                icon: Icon(Icons.timer),
                labelStyle: TextStyle(
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
                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                print(formattedTime); //output 14:59:00
                //DateFormat() is from intl package, you can format the time on any pattern you need.

                setState(() {
                  _endTime.text = formattedTime; //set the value of text field.
                });
              } else {
                print("Time is not selected");
              }
            },
          ),
          const SizedBox(height: 30),
          DropdownButtonFormField(
            decoration: const InputDecoration(
                labelText: "Clinical Rotation Number",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
            items: ['1', '2', '3', '4'].map((location) {
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
                labelText: "Duration",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
            items: ['0:30', '1:30', '2:00'].map((location) {
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
                labelText: "Session Type",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
            items: [
              'Ward Rounds',
              'Supervision',
              'Team meeting',
              'Morning report',
              'Work Visit',
              'Assistive device fabrication / adaptation'
            ].map((location) {
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
                labelText: "Supervision Type",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
            items: [
              'Case Supervisor',
              'Clinical Supervisor',
              'Academic Supervisor'
            ].map((location) {
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
                labelText: "Assistive device fabrication/adaptation Type",
                border: OutlineInputBorder(),
                labelStyle:  TextStyle(
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
            items: [
              'Wheelchair',
              'Splint',
              'Corner seat',
              'Routine chart',
              'Medication tracker',
              'Communication Charts',
              'Other'
            ].map((location) {
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
                labelText: "Log Session Status",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
            items: ['Conduct session', 'Canceled', 'Postponed'].map((location) {
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
          const SizedBox(height: 30),
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
            onPressed: () {
              _addEvent();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _addEvent() async {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();
    final title = _titleController.text;
    final startTime = _startTime.text;
    final endTime = _endTime.text;
    final mark = _mark.text;
    final comments = _comments.text;
    final number = _number.text;
    final markDate = _mark_date.text;
    final status  = _status;
    final rotation = _rotation;
    final duration = _duration;
    final sessionType = _sessionType;
    final supervision = _Supervision;
    final assistive = _assistive;
    final logStatus = _logStatus;
    const logSession = "Indirect";

    if (title.isEmpty) {
      print('title cannot be empty');
      return;
    }
    await FirebaseFirestore.instance.collection('sessionLogs').add({
      "uid": uid,
      "title": title,
      "date": Timestamp.fromDate(_selectedDate),
      "number": number,
      "rotation": rotation,
      "startTime": startTime,
      "endTime": endTime,
      "duration": duration,
      "sessionType": sessionType,
      "supervision": supervision,
      "assistive": assistive,
      "logStatus": logStatus,
      "status": status,
      "comments": comments,
      "mark": mark,
      "markDate": markDate,
      "logSession" : logSession,

    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
