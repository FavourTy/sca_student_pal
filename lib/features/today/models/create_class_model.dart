class CreateNewClass {
  int? id;
  String? courseTitle;
  String? courseCode;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  // Constructor
  CreateNewClass({
    this.id,
    this.courseTitle,
    this.courseCode,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  // Factory constructor for JSON deserialization
  factory CreateNewClass.fromJson(Map<String, dynamic> json) {
    return CreateNewClass(
      id: json['id'],
      courseTitle: json['title'],
      courseCode: json['note'],
      isCompleted: json['isCompleted'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      color: json['color'],
      remind: json['remind'],
      repeat: json['repeat'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': courseTitle,
      'note': courseCode,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }
}
