class RecentSessions {
  final String? icon, title, date, type, status;

  RecentSessions(
      {this.icon, this.title, this.date, this.type, this.status});
}

List recentUsers = [
  RecentSessions(
    icon: "assets/icons/xd_file.svg",
    title: "OT Session",
    type: "Direct Session",
    //email: "7:30",
    date: "01-03-2021",
    status: "Completed",
  ),
  RecentSessions(
    icon: "assets/icons/Figma_file.svg",
    title: "Group Session",
    type: "Indirect Session",
    //email: "8:00",
    date: "27-02-2021",
    status: "Postponed",
  ),


];
