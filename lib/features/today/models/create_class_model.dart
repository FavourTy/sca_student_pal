class CreateNewClass {
  int? id;
  int? courseId;
  int? isCompleted;
  String? startDate;
  String? endDate;
  List<String> recurrence;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;
  String? title;
  String? note;
  int? color;

  // Constructor
  CreateNewClass({
    this.courseId,
    this.id,
    this.isCompleted,
    this.startDate,
    this.endDate,
    this.recurrence = const [],
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
    this.title,
    this.note,
    this.color,
  });

  // Factory constructor for JSON deserialization
  factory CreateNewClass.fromJson(Map<String, dynamic> json) {
    return CreateNewClass(
      id: json['id'],
      courseId: json['courseId'],
      isCompleted: json['isCompleted'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      recurrence: (json['recurrence'] as String).split(", "),
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind'],
      repeat: json['repeat'],
      title: json['title'],
      note: json['note'],
      color: json['color'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'isCompleted': isCompleted,
      'startDate': startDate,
      'endDate': endDate,
      'recurrence': recurrence.join(", "),
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
      'title': title,
      'note': note,
      'color': color,
    };
  }
}
