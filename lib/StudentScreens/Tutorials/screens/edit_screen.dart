import 'package:flutter/material.dart';
import '../../../theme/colors/light_colors.dart';
import '../res/custom_colors.dart';
import '../utils/database.dart';
import '../widgets/app_bar_title.dart';
import '../widgets/edit_item_form.dart';

class EditScreen extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String currentDate;
  final String documentId;
  final String currentType;

  EditScreen({
    required this.currentTitle,
    required this.currentDescription,
    required this.currentDate,
    required this.currentType,
    required this.documentId,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _titleFocusNode = FocusNode();

  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();

  bool _isDeleting = false;

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
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Database.deleteItem(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditItemForm(
              documentId: widget.documentId,
              titleFocusNode: _titleFocusNode,
              descriptionFocusNode: _descriptionFocusNode,
              dateFocusNode: _dateFocusNode,
              currentTitle: widget.currentTitle,
              currentDescription: widget.currentDescription,
              currentDate: widget.currentDate,
              currentType: widget.currentType,
            ),
          ),
        ),
      ),
    );
  }
}
