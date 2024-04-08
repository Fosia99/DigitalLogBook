import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../theme/colors/light_colors.dart';

class PhysicalOutput extends StatefulWidget {
  @override

  late final rotNum;
  PhysicalOutput(this.rotNum);

  _ListViewExampleState createState() => _ListViewExampleState(rotNum);
}

class _ListViewExampleState extends State<PhysicalOutput> {
  late final rotNum;
  _ListViewExampleState(this.rotNum);


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _completedDate1Controller = TextEditingController();
  final TextEditingController _completedDate2Controller = TextEditingController();
  final TextEditingController _completedDate3Controller = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  bool _isFormVisible = false;
  String _selectedItem = '';
  String _userID = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  int _selectedIndex = -1;
  List<String> items =
  ['Attend and participate in at least 2 ward rounds or team meetings',
    'Attend and assist at least 2 wheelchair seating sessions (with an Occupational Therapist- including both assessment and prescription of wheelchair)- if possible and appropriate',
    'Observe and assist in the fabrication of at least 4 basic splints (Adult or paeds)',
    'Assess and treat at least 1 patient in: ICU or Acute care (if appropriate)',
    'Assess and treat at least 1 patient in: Surgical ward (burns, amputations, etc.)',
    'Assess and treat at least 1 patient in: TB ward (adult) or Spinal cord injury',
    'Assess and treat at least 1 patient in: Flexor or extensor tendon injury or Oncology ward',
    'Assess and treat at least 1 patient in: Other hand diagnosis (i.e. OA)- if appropriate',
    'Observe at least one formal clinical intervention demonstration by the clinical or academic supervisor per week of the clinical rotation: Week 1 ',
    'Observe at least one formal clinical intervention demonstration by the clinical or academic supervisor per week of the clinical rotation: Week 2 ',
    'Observe at least one formal clinical intervention demonstration by the clinical or academic supervisor per week of the clinical rotation: Week 3 )',
    'Observe at least one formal clinical intervention demonstration by the clinical or academic supervisor per week of the clinical rotation: Week 4 ',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #1',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #2',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #3',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #4',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #5',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #6',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #7',
    'Demonstrate and name at least one technique per week (splint, transfers, positioning, etc.) to either your academic or clinical supervisor: #8',
    'Communicate your outcomes for EACH patient you are seeing that day DAILY to your clinical supervisor (COMPULSORY- this must be signed off every day in your logbook) ',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return ListTile(
                  leading: Icon(Icons.list_outlined),

                  title: Text(item),
                  tileColor: _selectedIndex == index ? LightColors.kLightYellow : null,
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _showForm(item);
                    });
                  },
                  trailing: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
            ),
          ),
          _isFormVisible ? _buildForm() : Container(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedItem,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            'Completion Date 1:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: _completedDate1Controller,
            decoration: const InputDecoration(
              //labelText:  'Completion Date:',
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
                  _completedDate1Controller.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
          ),
          const SizedBox(height: 10.0),
          Text(
            'Completion Date 2:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: _completedDate2Controller,
            decoration: const InputDecoration(
              //labelText:  'Completion Date:',
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
                  _completedDate2Controller.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
          ),
          const SizedBox(height: 10.0),
          Text(
            'Completion Date 3:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: _completedDate3Controller,
            decoration: const InputDecoration(
              //labelText:  'Completion Date:',
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
                  _completedDate3Controller.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _remarksController,
            decoration: InputDecoration(labelText: 'Remarks',
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _saveAndUpdateData();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showForm(String item) {
    setState(() {
      _selectedItem = item;
      _completedDate1Controller.text = '';
      _completedDate2Controller.text = '';
      _completedDate3Controller.text = '';
      _remarksController.text = '';
      _userID='';
      _isFormVisible = true;
    });

    // Retrieve data from Firebase
    FirebaseFirestore.instance
        .collection('Physical')
        .doc(_selectedItem)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        // Extract data from the snapshot
        var data = snapshot.data();

        // Populate the respective fields with the retrieved data
        setState(() {
          _completedDate1Controller.text = data!['completedDate1'];
          _completedDate2Controller.text = data['completedDate2'];
          _completedDate3Controller.text = data['completedDate3'];
          _remarksController.text = data['remarks'];
          _userID = data['uid'];
        });
      }
    })
        .catchError((error) {
      print('Error retrieving data: $error');
    });
  }


  void _saveAndUpdateData() {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();
    final String completedDate1 = _completedDate1Controller.text;
    final String completedDate2 = _completedDate2Controller.text;
    final String completedDate3 = _completedDate3Controller.text;
    final String remarks = _remarksController.text;


    // Update the item data in Firebase
    _firestore.collection('Physical').doc(_selectedItem).set({
      'completedDate1': completedDate1,
      'completedDate2': completedDate2,
      'completedDate3': completedDate3,
      'remarks': remarks,
      'uid':uid,
      'rotation':rotNum,

    })
        .then((_) {
      setState(() {
        _selectedItem = '';
        _completedDate1Controller.text = '';
        _completedDate2Controller.text = '';
        _completedDate3Controller.text = '';
        _remarksController.text = '';
        _userID='';
        _isFormVisible = false;
      });

      _firestore
          .collection('Physical')
          .where('uid', isEqualTo: uid)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((documentSnapshot) {
          documentSnapshot.reference.set({
            'completedDate1': completedDate1,
            'completedDate2': completedDate2,
            'completedDate3': completedDate3,
            'remarks': remarks,
            'uid': uid,
            'rotation':rotNum,
          });
        });
      })
          .then((_) {
        setState(() {
          _selectedItem = '';
          _completedDate1Controller.text = '';
          _completedDate2Controller.text = '';
          _completedDate3Controller.text = '';
          _remarksController.text = '';
          _userID = '';
          _isFormVisible = false;
        });
      });


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data')),
      );
    });
  }
}