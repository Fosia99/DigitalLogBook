import '/reports/core/constants/color_constants.dart';
import '/reports/core/utils/colorful_tag.dart';
import '/reports/models/recent_sessions_model.dart';
import 'package:flutter/material.dart';

class RecentDiscussions extends StatelessWidget {
  const RecentDiscussions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Open Positions",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: defaultPadding,
              columns: [
                DataColumn(
                  label: Text("Position Name"),
                ),
                DataColumn(
                  label: Text("Create Date"),
                ),
                DataColumn(
                  label: Text("Total Application"),
                ),
              ],
              rows: List.generate(
                recentUsers.length,
                (index) => recentUserDataRow(recentUsers[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserDataRow(RecentSessions sessionInfo) {
  return DataRow(
    cells: [
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getRoleColor(sessionInfo.status).withOpacity(.2),
            border: Border.all(color: getRoleColor(sessionInfo.status)),
            borderRadius: BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          child: Text(sessionInfo.status!))),
      DataCell(Text(sessionInfo.date!)),
      DataCell(Text(sessionInfo.type!)),
    ],
  );
}
