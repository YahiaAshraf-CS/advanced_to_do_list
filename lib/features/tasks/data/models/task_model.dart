class TaskModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String category;
  final bool isCompleted;
  final String userId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.isCompleted,
    required this.userId,
  });

  // transform Map from Firestore to TaskModel
  factory TaskModel.fromMap(Map<String, dynamic> map, String documentId) {
    return TaskModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      category: map['category'] ?? 'General',
      isCompleted: map['isCompleted'] ?? false,
      userId: map['userId'] ?? '',
    );
  }

// transform TaskModel to Map to save in Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'category': category,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }
}
