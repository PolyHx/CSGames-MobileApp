class Activity {
  String id;
  String name;
  DateTime beginDate;
  DateTime endDate;
  String location;
  List<String> attendees;
  Map<String, dynamic> description;

  Activity({
    this.id,
    this.name,
    this.beginDate,
    this.endDate,
    this.location,
    this.attendees,
    this.description
  });

  Activity.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    name = map['name'];
    beginDate = DateTime.parse(map['beginDate']);
    endDate = DateTime.parse(map['endDate']);
    location = map['location'];
    attendees = List.castFrom<dynamic, String>(map['attendees']);
    description = Map.castFrom<dynamic, dynamic, String, String>(map['description']);
  }
}