import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_logbook/planner/screens/add_event_indirect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/planner/screens/edit_event.dart';
import 'package:table_calendar/table_calendar.dart';
import '/theme/colors/light_colors.dart';
import '/planner/model/event.dart';
import '/planner/model/event2.dart';
import '../widgets/event_item.dart';
import 'add_event_direct.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MyHomePage extends StatefulWidget {
  late final rotNum;

  MyHomePage(this.rotNum);

  @override
  State<MyHomePage> createState() => _MyHomePageState(rotNum);
}

class _MyHomePageState extends State<MyHomePage> {
  late final rotNum;

  _MyHomePageState(this.rotNum);

  final FirebaseAuth auth = FirebaseAuth.instance;

  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    final User? user = auth.currentUser;
    final uid = user?.uid.toString();

    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    _events = {};

    final snap1 = await FirebaseFirestore.instance
        .collection('sessionLogs')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .where('uid', isEqualTo: uid)
        .get();

    for (var doc in snap1.docs) {
      final event = Event.fromFirestore(doc);
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    //print('UID: $uid');
    setState(() {});
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColors.kWhite,
        appBar: AppBar(
          title: const Text('Planner'),
          elevation: 0,
          backgroundColor: LightColors.kDarkYellow,
        ),
        body: ListView(
          children: [
            Container(
              //color: Colors.grey,
              child: TableCalendar(
                eventLoader: _getEventsForTheDay,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                focusedDay: _focusedDay,
                firstDay: _firstDay,
                lastDay: _lastDay,
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                  _loadFirestoreEvents();
                },
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  print(_events[selectedDay]);
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(
                    color: LightColors.kYellow,
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightColors.kYellow,
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: LightColors.kTeal,
                  ),
                  outsideDaysVisible:
                      false, // Hide days outside the current month
                  //cellMargin: EdgeInsets.symmetric(horizontal: 2.0),
                  //cellMargin: EdgeInsets.symmetric(vertical: 2.0),// Add horizontal margin between cells
                  //cellMarginVertical: 2.0, // Add vertical margin between cells
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    final formatter = DateFormat(
                        'd MMMM yyyy'); // Define the desired date format
                    final formattedDate = formatter.format(day);
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.black, // Set the desired text color
                          fontSize: 16, // Set the desired font size
                          fontWeight:
                              FontWeight.bold, // Set the desired font weight
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            ..._getEventsForTheDay(_selectedDay).map(
              (event) => EventItem(
                  event: event,
                  onTap: () async {
                    final res = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditEvent(
                            firstDate: _firstDay,
                            lastDate: _lastDay,
                            event: event),
                      ),
                    );
                    if (res ?? false) {
                      _loadFirestoreEvents();
                    }
                  },
                  onDelete: () async {
                    final delete = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Delete Event?"),
                        content: const Text("Are you sure you want to delete?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red[900],
                            ),
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                    if (delete ?? false) {
                      await FirebaseFirestore.instance
                          .collection('sessionLogs')
                          .doc(event.id)
                          .delete();
                      _loadFirestoreEvents();
                    }
                    if (delete ?? false) {
                      await FirebaseFirestore.instance
                          .collection('Tutorials')
                          .doc(event.id)
                          .delete();
                      _loadFirestoreEvents();
                    }
                  }),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
            icon: Icons.add,
            backgroundColor: LightColors.kYellow,
            children: [
              SpeedDialChild(
                child:
                    const Icon(Icons.add_circle_outline, color: Colors.black),
                label: 'Direct Session',
                labelStyle: TextStyle(
                    color: Colors.black, //<-- SEE HERE
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                backgroundColor: LightColors.kRed,
                onTap: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEventDirect(
                        firstDate: _firstDay,
                        lastDate: _lastDay,
                        selectedDate: _selectedDay,
                      ),
                    ),
                  );
                  if (result ?? false) {
                    _loadFirestoreEvents();
                  }
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.add_circle, color: Colors.black),
                label: 'Indirect Session',
                labelStyle: TextStyle(
                    color: Colors.black, //<-- SEE HERE
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                backgroundColor: LightColors.kDarkYellow,
                onTap: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEventIndirect(
                        firstDate: _firstDay,
                        lastDate: _lastDay,
                        selectedDate: _selectedDay,
                      ),
                    ),
                  );
                  if (result ?? false) {
                    _loadFirestoreEvents();
                  }
                },
              ),
            ]));
  }
}
