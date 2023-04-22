
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/theme/colors/light_colors.dart';
import '/widgets/back_button.dart';

class SupProfile extends StatefulWidget {
  static String TAG = "SupProfile";

  @override
  SupProfileState createState() => SupProfileState();
}

class SupProfileState extends State<SupProfile>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _status = true;
  final _formKey = GlobalKey<FormState>();

  final FocusNode myFocusNode = FocusNode();
  var _name = '';
  var _surname = '';
  var _staffNumber = '';
  var _email = '';
  var _mobile = '';

  var optionsCourse = [
    'Occupational Therapy',
    'Nurse',
    'Pharmacy',
  ];
  var _currentItemSelectedCourse = "Occupational Therapy";
  var _course = "Occupational Therapy";

 // var optionsYears = ["1", "2", "3", "4"];
 // var _currentItemSelectedYear = "1";
 // var _year = "1";

  @override

  Widget build(BuildContext context) {
    var downwardIcon = const Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );


    return Scaffold(

        backgroundColor: LightColors.kGreen,
        appBar: AppBar(

          backgroundColor: LightColors.kGreen,
          title: const Text(
            "Student Profile",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[

              Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, top: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Stack(fit: StackFit.loose, children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: ExactAssetImage(
                                            'assets/images/as.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 90.0, right: 100.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    CircleAvatar(
                                      backgroundColor: LightColors.kGreen,
                                      radius: 25.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: LightColors.kDarkYellow,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : Container(),
                                    ],
                                  )
                                ],
                              )),
                          Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10.0, right: 5.0),
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        key: const ValueKey('name'),
                                        decoration: const InputDecoration(
                                            labelText: "Name",
                                            labelStyle: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            )),
                                        autocorrect: false,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value != null) {
                                            return 'Please enter a valid title';
                                          }
                                          return value;
                                        },
                                        onSaved: (value) {
                                          _name = value!;
                                        },
                                      ),
                                      TextFormField(
                                        key: const ValueKey('surname'),
                                        decoration: const InputDecoration(
                                            labelText: "Surname",
                                            labelStyle: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            )),
                                        autocorrect: false,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value != null) {
                                            return 'Please enter a valid title';
                                          }
                                          return value;
                                        },
                                        onSaved: (value) {
                                          _surname = value!;
                                        },
                                      ),
                                      TextFormField(
                                        key: const ValueKey('staffNumber'),
                                        decoration: const InputDecoration(
                                            labelText: "Student Number",
                                            labelStyle: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            )),
                                        autocorrect: false,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value != null) {
                                            return 'Please enter a valid title';
                                          }
                                          return value;
                                        },
                                        onSaved: (value) {
                                          _staffNumber = value!;
                                        },
                                      ),
                                      TextFormField(
                                        key: const ValueKey('mobile'),
                                        decoration: const InputDecoration(
                                            labelText: "Mobile Number",
                                            labelStyle: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            )),
                                        autocorrect: false,
                                        textCapitalization:
                                        TextCapitalization.none,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value != null) {
                                            return 'Please enter a valid title';
                                          }
                                          return value;
                                        },
                                        onSaved: (value) {
                                          _mobile = value!;
                                        },
                                      ),
                                      const SizedBox(height: 30.0),
                                      Row(
                                        key: const ValueKey('course'),
                                        children: [
                                          const Text(
                                            "Course: ",
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: LightColors.kGreen,
                                            ),
                                          ),
                                          const SizedBox(height: 10.0),
                                          DropdownButton<String>(
                                            dropdownColor: Colors.white,
                                            isDense: true,
                                            isExpanded: false,
                                            iconEnabledColor: Colors.white,
                                            focusColor: Colors.white,
                                            items: optionsCourse.map(
                                                    (String dropDownStringItem) {
                                                  return DropdownMenuItem<String>(
                                                    value: dropDownStringItem,
                                                    child: Text(
                                                      dropDownStringItem,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                            onChanged: (newValueSelected) {
                                              setState(() {
                                                _currentItemSelectedCourse =
                                                newValueSelected!;
                                                _course = newValueSelected;
                                              });
                                            },
                                            value: _currentItemSelectedCourse,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30.0),
                                      !_status
                                          ? _getActionButtons()
                                          : new Container(),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  final User user = await auth.currentUser!;
                  final uid = user.uid.toString();

                  Map<String, dynamic> data = {
                    "userId": uid,
                    "name": _name,
                    "surname": _surname,
                    "staffNumber": _staffNumber,
                    "email": _email,
                    "mobile": _mobile,
                    "course": _course

                  };
                  FirebaseFirestore.instance
                      .collection("Lecturer")
                      .add(data);

                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                child: const Text("Save"),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: RaisedButton(
                    child: Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return  GestureDetector(
      child: const CircleAvatar(
        backgroundColor: LightColors.kGreen,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () async{

        final User user = await auth.currentUser!;
        final uid = user.uid.toString();

        Map<String, dynamic> newData = {
          "userId": uid,
          "name": _name,
          "surname": _surname,
          "staffNumber": _staffNumber,
          "email": _email,
          "mobile": _mobile,
          "course": _course

        };
        FirebaseFirestore.instance
            .collection("LecturerProfile")
            .doc(uid)
            .update(newData);
        setState(() {
          _status = false;
        });
      },
    );
  }
}
