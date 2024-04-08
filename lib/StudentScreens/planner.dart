import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late DateTime _firstDay;
  late DateTime _lastDay;
  Map<DateTime, List<dynamic>> _events = {};

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchEventsFromFirebase();
  }

  void _fetchEventsFromFirebase() {
    firestore.collection('Indirect').get().then((snapshot) {
      snapshot.docs.forEach((document) {
        final event = document.data();
        final eventDate = DateTime.parse(event['date']);
        if (_events[eventDate] == null) {
          _events[eventDate] = [];
        }
        _events[eventDate]?.add(event);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _firstDay = DateTime(_selectedDay.year, _selectedDay.month - 3, 1);
    _lastDay = DateTime(_selectedDay.year, _selectedDay.month + 4, 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Schedule'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            firstDay: _firstDay,
            lastDay: _lastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          if (_events[_selectedDay] != null)
            ...?_events[_selectedDay]?.map((event) => ListTile(
              title: Text(event['title']),
              subtitle: Text(event['logStatus']),
            ))
        ],
      ),
    );
  }
}
