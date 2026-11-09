class TaskModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String category;
  final String iconName;
  final int colorValue;
  final bool isCompleted;
  final String userId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.iconName,
    required this.colorValue,
    required this.isCompleted,
    required this.userId,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String documentId) {
    return TaskModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      category: map['category'] ?? 'General',
      iconName: map['iconName'] ?? 'folder',
      colorValue: map['colorValue'] ?? 0xFF2196F3,
      isCompleted: map['isCompleted'] ?? false,
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'category': category,
      'iconName': iconName,
      'colorValue': colorValue,
      'isCompleted': isCompleted,
      'userId': userId,
    };
  }
}
