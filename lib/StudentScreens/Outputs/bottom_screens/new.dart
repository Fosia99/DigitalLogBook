import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class ChecklistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        home: TaskListScreen(),
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<TaskProvider>(context).getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!.docs;
            return ListView.separated(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = Task.fromSnapshot(tasks[index]);
                return ListTile(
                  leading: Icon(Icons.list_outlined),
                  title: Text(task.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(task: task),
                      ),
                    );
                  },
                  trailing: Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Divider(); },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _dateController;
  late TextEditingController _remarksController;
  late TaskProvider _taskProvider;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: widget.task.completedDate);
    _remarksController = TextEditingController(text: widget.task.remarks);
    _taskProvider = Provider.of<TaskProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Completion Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                //labelText: 'Completion Date:',
                  icon: Icon(Icons.calendar_today),
                  labelStyle: const TextStyle(
                      color: Colors.black, //<-- SEE HERE
                      fontSize: 18,
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
            SizedBox(height: 20),
            Text(
              'Remarks:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _remarksController,
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveTaskDetails();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTaskDetails() {
    final completedDate = _dateController.text;
    final remarks = _remarksController.text;

    final updatedTask = Task(
      widget.task.name,
      completedDate: completedDate,
      remarks: remarks,
    );

    _taskProvider.updateTask(updatedTask);
    Navigator.pop(context);
  }
}

class Task {
  final String name;
  String completedDate;
  String remarks;

  Task(this.name, {this.completedDate = '', this.remarks = ''});

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        completedDate = snapshot['completedDate'],
        remarks = snapshot['remarks'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'completedDate': completedDate,
    'remarks': remarks,
  };
}

class TaskProvider extends ChangeNotifier {
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('Mental');

  Stream<QuerySnapshot> getTasks() {
    return tasksCollection.snapshots();
  }

  Future<void> updateTask(Task task) async {
    await tasksCollection.doc(task.name).set(task.toJson());
    notifyListeners();
  }
}
