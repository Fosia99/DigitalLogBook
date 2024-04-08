import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/../../theme/colors/light_colors.dart';
import '../res/custom_colors.dart';
import '../utils/database.dart';
import '../utils/validator.dart';

import 'custom_form_field.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode dateFocusNode;

  final String currentTitle;
  final String currentDescription;
  final String currentDate;
  final String currentType;
  final String documentId;

  const EditItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.dateFocusNode,

    required this.currentTitle,
    required this.currentDescription,
    required this.currentDate,
    required this.currentType,
    required this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  var _tutorialType = '';
  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.currentTitle,
    );

    _descriptionController = TextEditingController(
      text: widget.currentDescription,
    );
    _dateController = TextEditingController(
      text: widget.currentDate,
    );

    _tutorialType = widget.currentType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.0),
                Text(
                  'Topic',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _titleController,
                  focusNode: widget.titleFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Topic',
                  hint: 'Enter your Tutorial topic',
                ),
                SizedBox(height: 24.0),
                Text(
                  'Tutorial Type',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder( borderSide: BorderSide(color: Colors.black),),
                      labelStyle: TextStyle(
                          color: Colors.black, //<-- SEE HERE
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  value: "Reflection",
                  onChanged: (newValue) {
                    setState(() {
                      _tutorialType = (newValue as String).toLowerCase();
                    });
                  },
                  items: [
                    'Reflection',
                    'Occupational Performance Area',
                    'Diagnosis and Technique',
                    'Occupational Therapy Process',

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
                SizedBox(height: 24.0),
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CustomFormField(
                  maxLines: 5,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  focusNode: widget.descriptionFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Description',
                  hint: 'Enter your Tutorial description',
                ),
                SizedBox(height: 8.0),
                const Text(
                  'Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  focusNode: widget.dateFocusNode,
                  controller: _dateController,
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
                        _dateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      LightColors.kGreen,
                    ),
                  ),
                )
              : Container(
                  width: double.maxFinite,
                  child: ElevatedButton(
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
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();
                      widget.dateFocusNode.unfocus();

                      if (_editItemFormKey.currentState!.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        await Database.updateItem(
                          docId: widget.documentId,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date: _dateController.text,
                          type:_tutorialType,
                        );

                        setState(() {
                          _isProcessing = false;
                        });

                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10.0),
                      child: Text(
                        'UPDATE TUTORIAL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.firebaseGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
