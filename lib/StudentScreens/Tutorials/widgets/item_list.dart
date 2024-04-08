import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../res/custom_colors.dart';
import '../screens/edit_screen.dart';
import '../utils/database.dart';
import '/theme/colors/light_colors.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data!.docs[index];
              String docID = snapshot.data!.docs[index].id;

              String title = noteInfo["title"];
              String description = noteInfo['description'];
              String date = noteInfo['date'];
              String type = noteInfo['type'];

              return Ink(
                decoration: BoxDecoration(
                  color: LightColors.kLightRed,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        currentTitle: title,
                        currentDescription: description,
                        currentDate: date,
                        currentType: type,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              LightColors.kDarkYellow,
            ),
          ),
        );
      },
    );
  }
}
