import 'package:flutter/material.dart';
import 'package:digital_logbook/theme/colors/light_colors.dart';

import '../res/custom_colors.dart';
import '../widgets/add_item_form.dart';
import '../widgets/app_bar_title.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _typeFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _dateFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: LightColors.kLightGreen,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: LightColors.kDarkYellow,
          title: AppBarTitle(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddItemForm(
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              dateFocusNode: _dateFocusNode,
              typeFocusNode: _typeFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
