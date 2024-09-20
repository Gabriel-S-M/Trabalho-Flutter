class Task {
  String? title;
  String? description;
  String? priority; // added priority field
  bool? isDone;

  Task({this.title, this.description, this.priority, this.isDone});

  Map toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority, // added priority to json
      'isDone': isDone
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    priority = json['priority']; // added priority from json
    isDone = json['isDone'];
  }
}
