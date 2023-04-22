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

class CreateNewSessionDirect extends StatefulWidget {
  static String TAG = "add_session";

  //const CreateNewSessionDirect(this.submitFn, this.isLoading, {Key key}) : super(key: key);

  final bool isLoading = false;

  @override
  CreateNewSessionDirectState createState() => CreateNewSessionDirectState();
}

class CreateNewSessionDirectState extends State<CreateNewSessionDirect> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _title = '';

  late DateTime _date;

  var _time = "7:30";
  var _selectVenue = '';
  var _bookVenue = "Yes";
  var _clients = "Yes";
  var _sessionType = "Individual Session";
  var _ageGroup = "Infancy (0-18 months)";
  var _communicated = "Yes";
  var _mentalHealth = "Neuro-developmental disorder";
  var _physicalHealth = "Mental Functions";
  var _setOutcomes = "Yes";
  var _completeSession = "Yes";
  var _submitSession = "Yes";
  var _prepareEandM = "Yes";
  var _prepareVenue = "Yes";
  var _sessionStatus = "Conduct session";
  var _reasonsCancel = '';
  var _returnedEandM = "Yes";
  var _cleanedVenue = "Yes";
  var _completeRecord = "Yes";
  var _completeReflection = "Yes";

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
        padding:
            const EdgeInsets.only(left: 20.0, right: 0.0, bottom: 8.0, top: 16),
        height: 320,
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
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
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
                      color:Colors.black),
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
                return value;
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
                      color: Colors.black),
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

            const SizedBox(height: 30.0),
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
                child: Column(children: <Widget>[
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
                  const SizedBox(height: 30.0),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Select venue",
                        border: OutlineInputBorder()),
                    onChanged: (val) {
                      setState(() {
                        _selectVenue = val;
                      });
                    },
                  ),
                  const SizedBox(height: 30.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Book venue", border: OutlineInputBorder()),
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
                  const SizedBox(height: 30.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: "Identify client(s)",
                        border: OutlineInputBorder()),
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
                  const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Type of Session",
                          border: OutlineInputBorder()),
                      value: "Individual Session",
                      onChanged: (newValue) {
                        setState(() {
                          _sessionType = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Individual Session', 'Small group', 'Median group', 'Large group', 'Caregiver training', 'Family psycho-education session'].map((location) {
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
                      decoration: const InputDecoration(
                          labelText: "Age group of Erickson",
                          border: OutlineInputBorder()),
                      value: " Infancy (0-18 months)",
                      onChanged: (newValue) {
                        setState(() {
                          _ageGroup = (newValue as String).toLowerCase();
                        });
                      },
                      items: [
                        ' Infancy (0-18 months)', 'Toddler (18 months-3 years)', 'Preschool-age (3-5 years)', 'School-age (5-12 years)', 'Adolescent (12-18 years)',
                        'Young adulthood (18-40 years)', 'Middle age (40-65 years)', 'Older adulthood (65+ years)'
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
                          labelText: "Communicate with stakeholders",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),
                    Row(children: const [
                      Text(
                        "Select diagnoses:",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10.0),
                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                          labelText: "Physical Health diagnoses ",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Mental Health diagnoses ",
                          border: OutlineInputBorder()),
                      value: "Neuro-developmental disorder",
                      onChanged: (newValue) {
                        setState(() {
                          _mentalHealth = (newValue as String).toLowerCase();
                        });
                      },
                      items: ['Neuro-developmental disorder',
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
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Set session outcomes",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Complete session plan",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Submit session plan",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Prepare Equipment and materials",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: "Prepare venue ",
                          border: OutlineInputBorder()),
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
                    const SizedBox(height: 30.0),

                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Session Status ",
                              border: OutlineInputBorder()),
                          value: "Conduct session",
                          onChanged: (newValue) {
                            setState(() {
                              _sessionStatus =
                                  (newValue as String).toLowerCase();
                            });
                          },
                          items: [
                            'Conduct session',
                            'Session canceled',
                            'Postponed'
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
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Reason for cancelling",
                              border: OutlineInputBorder()),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a reaseon' : null,
                          onChanged: (val) {
                            setState(() {
                              _reasonsCancel = val;
                            });
                          },
                        ),
                        const SizedBox(height: 30.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Return material / equipment used",
                              border: OutlineInputBorder()),
                          value: "Yes",
                          onChanged: (newValue) {
                            setState(() {
                              _returnedEandM =
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
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Clean venue",
                              border: OutlineInputBorder()),
                          value: "Yes",
                          onChanged: (newValue) {
                            setState(() {
                              _cleanedVenue =
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
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Return material / equipment used",
                              border: OutlineInputBorder()),
                          value: "Yes",
                          onChanged: (newValue) {
                            setState(() {
                              _returnedEandM =
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
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Complete record keeping",
                              border: OutlineInputBorder()),
                          value: "Yes",
                          onChanged: (newValue) {
                            setState(() {
                              _completeSession =
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
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              labelText: "Complete reflection",
                              border: OutlineInputBorder()),
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
                        const SizedBox(
                          height: 0,
                        ),
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceEvenly,
                            children: [

                          TextButton(
                            onPressed: () async {
                              final User user = await auth.currentUser!;
                              final uid = user.uid.toString();

                              Map<String, dynamic> data = {
                                "userId": uid,
                                "date": _date,
                                "title": _title,
                                "time": _time,
                                "selectedVenue": _selectVenue,
                                "bookedVenue": _bookVenue,
                                "clients": _clients,
                                "sessionType": _sessionType,
                                "ageGroup": _ageGroup,
                                "communicated": _communicated,
                                "mentalHealth": _mentalHealth,
                                "physicalHealth": _physicalHealth,
                                "sessionOutcomes": _setOutcomes,
                                "completedSession": _completeSession,
                                "submitSession": _submitSession,
                                "prepareEquipmentMaterials": _prepareEandM,
                                "prepareVenue": _prepareVenue,
                                "sessionStatus": _sessionStatus,
                                "reasonCancel": _reasonsCancel,
                                "returnedEquipment": _returnedEandM,
                                "cleanedVenue": _cleanedVenue,
                                "completeRecords": _completeRecord,
                                "completeReflection": _completeReflection,
                              };
                              FirebaseFirestore.instance
                                  .collection("DirectSessionLogs")
                                  .add(data);
                             // print("\t\t\tSession Logged Successfully");

                            },
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogSession(),
                                  ),
                                );
                              },
                              child: (const Text("Submit",
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ))),
                            ),
                          ),
                            ]
                        ),
                  const SizedBox(
                    height: 30,
                  ),

                      ],
                    ),
                  ),
                ),
              )
    ])));
  }
}
