import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _topicController = TextEditingController();
  final _studentSignatureController = TextEditingController();
  final _lecturerSignatureController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _topicController.dispose();
    _studentSignatureController.dispose();
    _lecturerSignatureController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save the form data to Firebase Firestore
      FirebaseFirestore.instance.collection('forms').add({
        'date': _dateController.text,
        'topic': _topicController.text,
        'studentSignature': _studentSignatureController.text,
        'lecturerSignature': _lecturerSignatureController.text,
      }).then((value) {
        // Reset the form after successful submission
        _formKey.currentState!.reset();
      }).catchError((error) {
        // Handle any errors that occur during form submission
        print('Error submitting form: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _topicController,
                decoration: const InputDecoration(labelText: 'Topic Covered'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a topic.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _studentSignatureController,
                decoration: const InputDecoration(labelText: 'Student Signature'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a student signature.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lecturerSignatureController,
                decoration: const InputDecoration(labelText: 'Lecturer Signature'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a lecturer signature.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


