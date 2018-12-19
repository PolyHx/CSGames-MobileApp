class AppNotification {
  String id;
  String title;
  DateTime date;

  AppNotification({
    this.id,
    this.title,
    this.date
  });

  AppNotification.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    date = map['date'];
  }
}