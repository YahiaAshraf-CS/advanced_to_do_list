import 'package:advanced_to_do_list/features/tasks/data/notefication/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:advanced_to_do_list/features/tasks/data/models/task_model.dart';


class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _tasksRef {
    final uid = _auth.currentUser?.uid ?? 'default_user';
    return _firestore.collection('users').doc(uid).collection('tasks');
  }

  Stream<List<TaskModel>> getUserTasks() {
    return _tasksRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> addTask({
    required String title,
    required String description,
    required String category,
    required String date,
    required String time,
  }) async {
    final uid = _auth.currentUser?.uid ?? 'default_user';

    String iconName = 'folder';
    int colorValue = 0xFF2196F3;

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('categories')
          .where('name', isEqualTo: category)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final catData = querySnapshot.docs.first.data();
        iconName = catData['iconName'] ?? 'folder';
        colorValue = catData['colorValue'] ?? 0xFF2196F3;
      }
    } catch (_) {}

    final docId = _tasksRef.doc().id;

    final newTask = TaskModel(
      id: docId,
      title: title,
      description: description,
      date: date,
      time: time,
      category: category,
      iconName: iconName,
      colorValue: colorValue,
      isCompleted: false,
      userId: uid,
    );

    await _tasksRef.doc(docId).set(newTask.toMap());

    try {
      final parsedDate = DateFormat('EEE, d MMM yyyy').parse(date);
      final timeParts = time.split(' ');
      final hm = timeParts[0].split(':');
      int hour = int.parse(hm[0]);
      int minute = int.parse(hm[1]);
      if (timeParts.length > 1 &&
          timeParts[1].toLowerCase() == 'pm' &&
          hour < 12) {
        hour += 12;
      }
      if (timeParts.length > 1 &&
          timeParts[1].toLowerCase() == 'am' &&
          hour == 12) {
        hour = 0;
      }

      final taskDateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        hour,
        minute,
      );

      final notificationId = docId.hashCode.abs();
      await NotificationService.scheduleTaskNotification(
        id: notificationId,
        title: 'Task Reminder ⏰',
        body: ' It\'s time for your task: $title',
        scheduledDate: taskDateTime,
      );
    } catch (_) {}
  }

  Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    await _tasksRef.doc(taskId).update({
      'isCompleted': isCompleted,
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksRef.doc(taskId).delete();
  }
}
