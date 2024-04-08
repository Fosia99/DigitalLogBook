import 'package:intl/intl.dart';

class CalendarData {
  final String name;

  final DateTime date;
  final String position;
  final String rating;

  String getDate() {
    final formatter = DateFormat('kk:mm');

    return formatter.format(date);
  }

  CalendarData({
    required this.name,
    required this.date,
    required this.position,
    required this.rating,
  });
}

final List<CalendarData> calendarData = [
  CalendarData(
    name: 'Test Direct',
    date: DateTime.now().add(Duration(days: -16, hours: 5)),
    position: "Completed",
    rating: '₽',
  ),
  CalendarData(
    name: 'Test Direct',
    date: DateTime.now().add(Duration(days: -5, hours: 8)),
    position: "Completed",
    rating: '₽',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -10, hours: 3)),
    position: "Completed",
    rating: '\$',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: 6, hours: 6)),
    position: "Postponed",
    rating: '\$',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -18, hours: 9)),
    position: "Completed",
    rating: '\$',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -12, hours: 2)),
    position: "Cancelled",
    rating: '\$',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -8, hours: 4)),
    position: "Completed",
    rating: '\$',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -3, hours: 6)),
    position: "Postponed",
    rating: '₽',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -2, hours: 6)),
    position: "Completed",
    rating: '₽',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -2, hours: 7)),
    position: "Incomplete",
    rating: '₽',
  ),
  CalendarData(
    name: 'Test Indirect',
    date: DateTime.now().add(Duration(days: -14, hours: 5)),
    position: "Completed",
    rating: '₽',
  ),
];
