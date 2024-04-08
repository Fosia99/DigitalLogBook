import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/colors/light_colors.dart';

class AddEventDirect extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  const AddEventDirect(
      {Key? key,
      required this.firstDate,
      required this.lastDate,
      this.selectedDate})
      : super(key: key);

  @override
  State<AddEventDirect> createState() => _AddEventState();
}

class _AddEventState extends State<AddEventDirect> {
  late DateTime _selectedDate;
  final _titleController = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _selectVenue = TextEditingController();
  final TextEditingController _reasonsCancel = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();

  var _rotation = '';
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
  final _completeRecord = '';
  var _completeReflection = '';

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
        title: const Text("Add Direct Session"),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
          TextField(
            controller: _selectVenue,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: 'Selected venue',
                labelText: 'Selected venue',
                labelStyle: TextStyle(
                    color: Colors.black, //<-- SEE HERE
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField(
            decoration: const InputDecoration(
                labelText: "Booked venue",
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
                labelStyle: TextStyle(
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
                labelStyle: TextStyle(
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
            decoration: const InputDecoration(
                labelText: "Communicate with stakeholders",
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
            isExpanded: true,
            decoration: const InputDecoration(
                labelText: "Physical Health diagnoses ",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
              ' Functions of the Cardiovascular, Haematological, Immunological and Respiratory Systems',
              ' Functions of the Digestive, Metabolic, Endocrine Systems',
              'Genitourinary and Reproductive Functions',
              ' Neuromusculoskeletal and Movement-Related Functions',
              'Functions of the Skin and Related Structures'
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
            isExpanded: true,
            decoration: const InputDecoration(
                labelText: "Mental Health diagnoses ",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
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
              'Schizophrenia Spectrum and other psychotic disorders',
              'Bipolar and related Disorders',
              'Depressive Disorders',
              'Anxiety Disorders',
              'Substance/Medication-Induced Anxiety Disorder',
              'Obsessive-Compulsive and related disorders',
              'Somatic Symptom and Related Disorders',
              'Feeding and Eating Disorders',
              'Elimination Disorders',
              'Sleep-Wake Disorders',
              'Breathing-Related Sleep Disorders',
              'Parasomnias',
              'Sexual Dysfunctions',
              'Gender Dysphoria',
              'Disruptive, Impulse-Control, and Conduct Disorders',
              'Substance-Related Disorders: Substance Use Disorders',
              'Alcohol-Related Disorders: Alcohol Use Disorder',
              'Cannabis-Related Disorders',
              'Hallucinogen-Related Disorders',
              'Inhalant-Related Disorder',
              'Opioid-Related Disorders',
              'Sedative-, Hypnotic-, or Anxiolytic-Related Disorders',
              'Stimulant-Related Disorders',
              'Tobacco-Related Disorders Tobacco Use Disorder',
              'Other (or Unknown) Substance–Related Disorder',
              'Non-Substance-Related Disorders',
              'Neurocognitive Disorders',
              'Personality Disorder',
              'Paraphilic Disorders',
              'Other Mental Disorders'
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
                labelText: "Set session outcomes",
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
            decoration: const InputDecoration(
                labelText: "Submited session plan",
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
            decoration: const InputDecoration(
                labelText: "Prepared Equipment and materials",
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
            decoration: const InputDecoration(
                labelText: "Session Status ",
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
                _sessionStatus = (newValue as String).toLowerCase();
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
          const SizedBox(height: 20),
          TextField(
            controller: _reasonsCancel,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                hintText: 'Reasons for Cancelling',
                labelText: 'Reasons for Cancelling',
                labelStyle: const TextStyle(
                    color: Colors.black, //<-- SEE HERE
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: const InputDecoration(
                labelText: "Returned material / equipment used",
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
            decoration: const InputDecoration(
                labelText: "Cleaned venue",
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
            decoration: const InputDecoration(
                labelText: "Returned material / equipment used",
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
            decoration: const InputDecoration(
                labelText: "Completed record keeping",
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
          const SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: const InputDecoration(
                labelText: "Completed reflection",
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
                _completeReflection = (newValue as String).toLowerCase();
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
            child: const Text("Save",
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }

  void _addEvent() async {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();
    final title = _titleController.text;
    final String? number = _number.text;
    final String? rotation = _rotation;
    final String? startTime = _startTime.text;
    final String? endTime = _endTime.text;
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
    const String? logSession = "Direct";

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
      "logSession": logSession,
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
