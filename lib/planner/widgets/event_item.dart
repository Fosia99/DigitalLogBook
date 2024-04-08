import 'package:flutter/material.dart';
import '../../theme/colors/light_colors.dart';
import '../model/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  final Function() onDelete;
  final Function()? onTap;
  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
        hoverColor: LightColors.kLightRed,
        leading: FlutterLogo(),
        title: Text(
          event.title,
          style: const TextStyle(
            color: Colors.black, // Set the desired text color
            fontSize: 14, // Set the desired font size
            fontWeight: FontWeight.bold, // Set the desired font weight
          ),
        ),
        subtitle: Text(
          " Start Time" + event.time,
          style: const TextStyle(
            color: Colors.black, // Set the desired text color
            fontSize: 14, // Set the desired font size
            fontWeight: FontWeight.bold, // Set the desired font weight
          ),
        ),
      ),
    );
  }
}
