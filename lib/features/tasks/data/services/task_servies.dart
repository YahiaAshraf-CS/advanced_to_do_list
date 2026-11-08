import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

 // tasks collection
  String get _tasksCollection => 'tasks';


  Future<void> addTask({
    required String title,
    required String description,
    required String date,
    required String time,
    required String category,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    await _firestore.collection(_tasksCollection).add({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'category': category,
      'isCompleted': false,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

 // get user tasks
  Stream<List<TaskModel>> getUserTasks() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection(_tasksCollection)
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // change task status
  Future<void> toggleTaskCompletion(String taskId, bool currentStatus) async {
    await _firestore.collection(_tasksCollection).doc(taskId).update({
      'isCompleted': !currentStatus,
    });
  }

  // delete the task
  Future<void> deleteTask(String taskId) async {
    await _firestore.collection(_tasksCollection).doc(taskId).delete();
  }
}
