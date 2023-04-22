import 'package:flutter/material.dart';
import '/screens//OccupationalDashboardScreen.dart';
import '/screens//LogSession.dart';
import '/theme/colors/light_colors.dart';
import '/widgets/back_button.dart';
import '/widgets/my_text_field.dart';
import '/widgets/top_container.dart';
import '/theme/colors/light_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CreateNewSessionInDirect extends StatefulWidget {
  static String TAG = "add_session";

  @override
  CreateNewSessionInDirectState createState() =>
      CreateNewSessionInDirectState();
}

class CreateNewSessionInDirectState extends State<CreateNewSessionInDirect> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _time = "7:30";
  var _duration = "30 minutes";
  late DateTime _date;
  var _sessionType = "Ward Rounds";
  var _Supervision = "Case Supervisor";
  var _assistive = "Wheelchair";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        TopContainer(
          width: 1000,
          padding: const EdgeInsets.only(
              left: 20.0, right: 0.0, bottom: 8.0, top: 16),
          height: 280,
          child: Column(
            children: <Widget>[
              MyBackButton(),
              const SizedBox(
                height: 30,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Add new session ',
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              TextFormField(
                key: const ValueKey('title'),
                decoration: const InputDecoration(
                    labelText: 'TITLE',
                    labelStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: LightColors.kGreen),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
                validator: (value) {
                  if (value != null) {
                    return 'Please enter a valid title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                key: const ValueKey('date'),
                decoration: const InputDecoration(
                    labelText: 'DATE',
                    labelStyle: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: LightColors.kGreen),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 45,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(2023, 1, 1),
                  onDateTimeChanged: (DateTime newDateTime) {
                    _date = newDateTime;
                  },
                ),
              ),

              // ignore: missing_return
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                decoration: BoxDecoration(
                  color: LightColors.kLightYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 5.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Time", border: OutlineInputBorder()),
                      value: "7:30",
                      onChanged: (newValue) {
                        setState(() {
                          _time = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['7:30', '8:30'].map((location) {
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
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Duration", border: OutlineInputBorder()),
                      value: "30 minutes",
                      onChanged: (newValue) {
                        setState(() {
                          _duration = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['30 minutes', '1:30','2:00'].map((location) {
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
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Session Type",
                          border: OutlineInputBorder()),
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
                    SizedBox(height: 20.0),

                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Supervision",
                          border: OutlineInputBorder()),
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

                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText:
                              "Assistive device fabrication / adaptation",
                          border: OutlineInputBorder()),
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
                        'Communication Charts'
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
                    const SizedBox(height: 30.0),
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          final User user = await auth.currentUser!;
                          final uid = user.uid.toString();

                          Map<String, dynamic> data = {
                            "userId": uid,
                            "date": _date,
                            "time": _time,
                            "duration": _duration,
                            "title": _title,
                            "sessionType": _sessionType,
                            "supervision": _Supervision,
                            "assistive": _assistive,
                          };
                          FirebaseFirestore.instance
                              .collection("IndirectSessionLogs")
                              .add(data);

                          print("\t\t\tSession Logged Successfully");

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogSession(),
                            ),
                          );
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: (const Text("Submit",
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ))),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        const SizedBox(height: 30.0),
      ])),
    );
  }
}
