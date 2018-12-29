class AppNotification {
  String id;
  String title;
  String body;
  String type;
  DateTime date;
  bool seen;

  AppNotification({
    this.id,
    this.title,
    this.body,
    this.date,
    this.seen
  });

  AppNotification.fromMap(Map<String, dynamic> map) {
    id = map['notification']['_id'];
    title = map['notification']['title'];
    body = map['notification']['body'];
    date = DateTime.parse(map['notification']['timestamp']);
    seen = map['seen'] == true;
    type = map['notification']['data']['type'];
  }
}