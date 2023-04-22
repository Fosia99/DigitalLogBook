
import 'package:flutter/material.dart';
import '/screens/OccupationalDashboardScreen.dart';
import '/screens/LogSession.dart';

import '/theme/colors/light_colors.dart';
import '/widgets/active_project_card.dart';
import '/widgets/back_button.dart';
import '/widgets/my_text_field.dart';
import '/widgets/task_column.dart';
import '/widgets/top_container.dart';




class NurseReportingHome extends StatefulWidget {
  static String TAG = "NurseReports";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NurseReportingHomeState();
  }
}

class NurseReportingHomeState extends State<NurseReportingHome> {
  var lstClinic = [
    {
      "clinic_image": "assets/images/clinic_image.png",
      "procedure_name": "HANDING OVER OF REPORTS",
      "procedure_frequency": "Twice"
    },
    {
      "clinic_image": "assets/images/clinic_image.png",
      "procedure_name": "WARD ROUNDS  ",
      "procedure_frequency": "Three Times"
    },
    {
      "clinic_image": "assets/images/clinic_image.png",
      "procedure_name": "INCIDENT REPORT WRITING ",
      "procedure_frequency": "Once"
    }
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        title: Text("REQUIRED REPORTS"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Container(
        alignment: Alignment.center,

        height: 550,
        width: 1800,
        color: Colors.transparent,
        padding:
            const EdgeInsets.only(left: 110.0, right: 0.0, bottom: 8.0, top: 16),
        child: ListView.builder(

            physics: BouncingScrollPhysics(),
            itemCount: lstClinic.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {

                  } else if (index == 1) {
                   // Navigator.pushNamed(context, PerformingTriage.TAG);
                  } else if (index == 2) {
                   // Navigator.pushNamed(context, PerformingTriage.TAG);
                  }
                },
                child: Padding(

                    padding: const EdgeInsets.only(top: 2.0),
                    child: Card(
color: LightColors.kLavender,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Column(

                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.adjust_rounded,
                                      size: 80,
                                      color: LightColors.kRed ,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(" "),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(" "),
                                            Text(
                                              '    ' +
                                                  lstClinic[index]
                                                          ["procedure_name"]!
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            Text(
                                                '    ' +
                                                    lstClinic[index]
                                                    ["procedure_frequency"]!
                                                        .toUpperCase())

                                          ],
                                        ),
                                        Column(
                                          children: [Text(" ")],
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
