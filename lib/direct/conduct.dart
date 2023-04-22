// @dart=2.15
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:digital_logbook/screens/Planner.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/widgets/back_button.dart';
import 'package:intl/intl.dart';
import '../screens/LogSession.dart';
import 'home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class DirectConduct extends StatefulWidget {
 // const DirectConduct({Key? key}) : super(key: key);
  late final rotNum;

  DirectConduct(this.rotNum);

  @override
  State<DirectConduct> createState() => _DirectConductState(rotNum);
}

class _DirectConductState extends State<DirectConduct> {
  late final rotNum;

  _DirectConductState(this.rotNum);

  final TextEditingController _title = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _selectVenue = TextEditingController();
  final TextEditingController _reasonsCancel = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();

  var _rotation ='';
  // var _endTime ='';
  var _bookVenue = '';
  var _clients = '';
  var _sessionType = '';
  var _ageGroup = '';
  var _communicated = '';
  var _mentalHealth = '';
  var _physicalHealth = '';
  var _setOutcomes = '';
  var _completeSession = '';
  var _submitSession = '';
  var _prepareEandM = '';
  var _prepareVenue = '';
  var _sessionStatus = 'conduct session';
  var _returnedEandM = '';
  var _cleanedVenue = '';
  var _completeRecord = '';
  var _completeReflection = '';

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference direct =
      FirebaseFirestore.instance.collection('direct');

  Future<void> createTodo([DocumentSnapshot? documentSnapshot]) async {
    String action = 'add';

    if (documentSnapshot != null) {
      action = 'update';
      _title.text = documentSnapshot['title'];
      _number.text = documentSnapshot['number'];
      _rotation = documentSnapshot['rotation'];
      _date.text = documentSnapshot['date'];
      _startTime.text = documentSnapshot['startTime'];
      _endTime.text = documentSnapshot['endTime'];
      _selectVenue.text = documentSnapshot['selectVenue'];
      _reasonsCancel.text = documentSnapshot['reasonsCancel'];
      _bookVenue = documentSnapshot['bookVenue'];
      _clients = documentSnapshot['clients'];
      _sessionType = documentSnapshot['sessionType'];
      _ageGroup = documentSnapshot['ageGroup'];
      _communicated = documentSnapshot['communicated'];
      _mentalHealth = documentSnapshot['mentalHealth'];
      _physicalHealth = documentSnapshot['physicalHealth'];
      _setOutcomes = documentSnapshot['setOutcomes'];
      _completeSession = documentSnapshot['completeSession'];
      _submitSession = documentSnapshot['submitSession'];
      _prepareEandM = documentSnapshot['prepareEandM'];
      _prepareVenue = documentSnapshot['prepareVenue'];
      _sessionStatus = documentSnapshot['sessionStatus'];
      _returnedEandM = documentSnapshot['returnedEandM'];
      _cleanedVenue = documentSnapshot['cleanedVenue'];
      _completeRecord = documentSnapshot['completeRecord'];
      _completeReflection = documentSnapshot['completeReflection'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 2),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                    TextField(
                      controller: _title,
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
                      controller: _selectVenue,
                      decoration: const InputDecoration(
                          labelText: 'Selected venue',
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Booked venue",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _bookVenue = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                          labelText: "Identifed client(s)",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _clients = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                          labelText: "Session Type",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Individual Session",
                      onChanged: (newValue) {
                        setState(() {
                          _sessionType = (newValue as String).toLowerCase();
                        });
                      },
                      items: [
                        'Individual Session',
                        'Group Session',
                        'Caregiver training',
                        'Family psycho-education session',
                        'Wheelchair seating',
                        'Splint fabrication'
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Age group of Erickson",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: " Infancy (0-18 months)",
                      onChanged: (newValue) {
                        setState(() {
                          _ageGroup = (newValue as String).toLowerCase();
                        });
                      },
                      items: [
                        ' Infancy (0-18 months)',
                        'Toddler (18 months-3 years)',
                        'Preschool-age (3-5 years)',
                        'School-age (5-12 years)',
                        'Adolescent (12-18 years)',
                        'Young adulthood (18-40 years)',
                        'Middle age (40-65 years)',
                        'Older adulthood (65+ years)'
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Communicate with stakeholders",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _communicated = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                    Row(children: const [
                      Text(
                        "Select diagnoses:",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Physical Health diagnoses ",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Mental Functions",
                      onChanged: (newValue) {
                        setState(() {
                          _physicalHealth = (newValue as String).toLowerCase();
                        });
                      },
                      items: [
                        'Mental Functions',
                        'Sensory Functions and Pain',
                        'Voice and Speech Functions',
                        'Functions of the Cardiovascular'
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Mental Health diagnoses ",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Neuro-developmental disorder",
                      onChanged: (newValue) {
                        setState(() {
                          _mentalHealth = (newValue as String).toLowerCase();
                        });
                      },
                      items: [
                        'Neuro-developmental disorder',
                        'Schizophrenia Spectrum ',
                        'Bipolar and related Disorders',
                        'Depressive Disorders'
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Set session outcomes",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _setOutcomes = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                          labelText: "Completed session plan",
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _completeSession = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                      decoration: InputDecoration(
                          labelText: "Submited session plan",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _submitSession = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                      decoration: InputDecoration(
                          labelText: "Prepared Equipment and materials",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _prepareEandM = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                          labelText: "Prepared venue ",
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _prepareVenue = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                      decoration: InputDecoration(
                          labelText: "Session Status ",
                          border: OutlineInputBorder(),
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
                          _sessionStatus = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Conduct session', 'Canceled', 'Postponed']
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: _reasonsCancel,
                      decoration: const InputDecoration(
                          labelText: 'Reasons for Cancelling',
                          labelStyle: const TextStyle(
                          color: Colors.black, //<-- SEE HERE
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Returned material / equipment used",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _returnedEandM = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                      decoration: InputDecoration(
                          labelText: "Cleaned venue",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _cleanedVenue = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Returned material / equipment used",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _returnedEandM = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Completed record keeping",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _completeSession = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Completed reflection",
                          border: OutlineInputBorder(),
                          labelStyle: const TextStyle(
                              color: Colors.black, //<-- SEE HERE
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      value: "Yes",
                      onChanged: (newValue) {
                        setState(() {
                          _completeReflection =
                              (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Yes', 'No'].map((location) {
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
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                        child: Text(action == 'add' ? 'add' : 'update',
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              //backgroundColor: LightColors.kRed,
                              color: Colors.black,
                            )),
                        onPressed: () async {
                          final User? user = await auth.currentUser;
                          final uid = user?.uid.toString();

                          final String? title = _title.text;
                          final String? number = _number.text;
                          final String? rotation = _rotation;
                          final String? startTime = _startTime.text;
                          final String? endTime = _endTime.text;
                          final String? date = _date.text;
                          final String? reasonsCancel = _reasonsCancel.text;
                          final String? selectVenue = _selectVenue.text;
                          final String? bookVenue = _bookVenue;
                          final String? clients = _clients;
                          final String? sessionType = _sessionType;
                          final String? ageGroup = _ageGroup;
                          final String? communicated = _communicated;
                          final String? mentalHealth = _mentalHealth;
                          final String? physicalHealth = _physicalHealth;
                          final String? setOutcomes = _setOutcomes;
                          final String? completeSession = _completeSession;
                          final String? submitSession = _submitSession;
                          final String? prepareEandM = _prepareEandM;
                          final String? prepareVenue = _prepareVenue;
                          final String? sessionStatus = _sessionStatus;
                          final String? returnedEandM = _returnedEandM;
                          final String? cleanedVenue = _cleanedVenue;
                          final String? completeRecord = _completeRecord;
                          final String? completeReflection = _completeReflection;

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
                                "completeReflection": completeReflection
                              });
                            }
                            if (action == 'update') {
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
                                "completeReflection": completeReflection
                              });
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DirectHome(rotNum),
                              ),
                            );
                          }
                        })
                  ])));
        });
  }

  Future<void> _deleteTodo(String todoId) async {
    await direct.doc(todoId).delete();

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
                          Text(
                            'My Direct Log Sessions',
                            style: TextStyle(fontSize: 18, color: Colors.white),
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
                        .collection('direct')
                        .where('uid', isEqualTo: uid)
                        .where('sessionStatus', isEqualTo: 'conduct session')
                        .where('rotation', isEqualTo: rotNum)
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

                              final documentSnapshotList = streamSnapshot.data?.docs;
                              var results = documentSnapshotList?.length;
                              return FocusedMenuHolder(
                                menuWidth:
                                    MediaQuery.of(context).size.width / 0.50,
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
                                      trailingIcon:
                                          const Icon(Icons.open_in_new),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.white,
                                            context: context,
                                            builder: (context) => Container(
                                                padding: const EdgeInsets.only(
                                                  left: 50.0,
                                                  right: 50.0,
                                                ),
                                                child: SingleChildScrollView(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
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
                                                              ' SESSION NUMBER : ',
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
                                                              'number'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                      ],
                                                    ),    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          margin:
                                                          const EdgeInsets
                                                              .all(15),
                                                          child: const Text(
                                                              ' CLINICAL ROTATION NUMBER : ',
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
                                                              'rotation'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red)),
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
                                                          child: const Text(
                                                              ' START TIME : ',
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
                                                                  'startTime'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red)),
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
                                                          child: const Text(
                                                              ' END TIME : ',
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
                                                                  'endTime'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red)),
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
                                                          child: const Text(
                                                              ' DATE : ',
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
                                                                  'date'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Select Venue: ',
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
                                                                  'selectVenue'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'BOOK VENUE: ',
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
                                                                  .all(5),
                                                          child: Text(
                                                              documentSnapshot[
                                                                  'bookVenue'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Identify client(s): ',
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
                                                                  'clients'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Type of Session: ',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
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
                                                              documentSnapshot[
                                                                  'sessionType'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Age group of Erickson: ',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
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
                                                              documentSnapshot[
                                                                  'ageGroup'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Communicate with stakeholders: ',
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
                                                                  'communicated'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Physical diagnoses: ',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
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
                                                              documentSnapshot[
                                                                  'physicalHealth'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Mental diagnoses: ',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
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
                                                              documentSnapshot[
                                                                  'mentalHealth'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Set session outcomes: ',
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
                                                                  'setOutcomes'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Complete session plan: ',
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
                                                                  'completeSession'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Submit session plan: ',
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
                                                                  'submitSession'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Prepare Equipment and materials: ',
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
                                                                  'prepareEandM'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Prepare venue: ',
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
                                                                  'prepareVenue'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Session Status: ',
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
                                                                  'sessionStatus'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Return material / equipment: ',
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
                                                                  'returnedEandM'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Clean venue: ',
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
                                                                  'cleanedVenue'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Complete record keeping: ',
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
                                                                  'completeRecord'],
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
                                                    Divider(
                                                        color: Colors.black),
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
                                                              'Completed reflection',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                              documentSnapshot[
                                                                  'completeReflection'],
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red)),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))));
                                      }),
                                  FocusedMenuItem(
                                      title: Text("Edit"),
                                      trailingIcon: Icon(Icons.edit),
                                      onPressed: () {
                                        createTodo(documentSnapshot);
                                      }),
                                  FocusedMenuItem(
                                      title: const Text("Session Cancelled"),
                                      trailingIcon: Icon(Icons.work),
                                      onPressed: () {
                                        direct.doc(documentSnapshot.id).update(
                                            {"sessionStatus": 'canceled'});
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
                                  FocusedMenuItem(
                                      title: const Text(
                                        "Download PDF",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                      trailingIcon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () async {
                                        // final font = await rootBundle.load("assets/fonts/Roboto-Bold.ttf");
                                        //final ttf = pw.Font.ttf(font);
                                        final pdf = pw.Document();

                                        pdf.addPage(
                                          pw.Page(
                                            build: (pw.Context context) =>
                                                pw.Center(
                                              child: pw.Text(
                                                documentSnapshot['title'],
                                              ),
                                            ),
                                          ),
                                        );

                                        final file = File('example.pdf');
                                        await file
                                            .writeAsBytes(await pdf.save());
                                      }),
                                ],
                                onPressed: () {},

                                child: Card(
                                  color:  Colors.white70,
                                  child: ListTile(

                                    leading: Icon(Icons.star),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTodo(),
        backgroundColor: LightColors.kRed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
