class AssignmentModel {
  int? id;
  String? title;
  String? description;
  int? classId;
  int? isCompleted;
  String? dueDate;
  int? remind;
  int? priority;
  String? reminderTime;
  String? reminderDate;
  int? notificationId;

  AssignmentModel(
      {this.classId,
      this.dueDate,
      this.id,
      this.isCompleted,
      this.description,
      this.remind,
      this.title,
      this.priority,
      this.reminderTime,
      this.reminderDate,
      this.notificationId});

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
        id: json['id'],
        classId: json['id'],
        dueDate: json['dueDate'],
        isCompleted: json['isCompleted'],
        description: json['note'],
        title: json['title'],
        remind: json['remind'],
        priority: json['priority'],
        reminderTime: json['reminderTime'],
        reminderDate: json['reminderDate'],
        notificationId: json['notificationId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
      'description': description,
      'title': title,
      'remind': remind,
      'priority': priority,
      'reminderTime': reminderTime,
      'reminderDate': reminderDate,
      'notificationId': notificationId
    };
  }
}
