import 'package:flutter/material.dart';

import '../../../theme/colors/light_colors.dart';
import '../res/custom_colors.dart';
import '../screens/add_screen.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/item_list.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: LightColors.kDarkYellow,
        title: AppBarTitle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
            ),
          );
        },
        backgroundColor:  LightColors.kDarkYellow,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ItemList(),
        ),
      ),
    );
  }
}
