import '/reports/core/constants/color_constants.dart';
import '/reports/screens/dashboard/components/calendart_widget.dart';
import '/reports/screens/dashboard/components/charts.dart';
import '/reports/screens/dashboard/components/user_details_mini_card.dart';
import 'package:flutter/material.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarWidget(),
          Text(
            "Logged Sessions Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          UserDetailsMiniCard(
            color: Color(0xff0293ee),
            title: "Direct Sessions Logs",
            amountOfHours: "240",
            numberOfIncrease: 1328,
          ),
          UserDetailsMiniCard(
            color: Color(0xfff8b250),
            title: "Indirect Sessions Logs",
            amountOfHours: "180",
            numberOfIncrease: 1328,
          ),
          UserDetailsMiniCard(
            color: Color(0xff845bef),
            title: "Completed Direct Sessions",
            amountOfHours: "60",
            numberOfIncrease: 1328,
          ),
          UserDetailsMiniCard(
            color: Color(0xff13d38e),
            title: "Completed Indirect Sessions",
            amountOfHours: "80",
            numberOfIncrease: 140,
          ),
        ],
      ),
    );
  }
}
