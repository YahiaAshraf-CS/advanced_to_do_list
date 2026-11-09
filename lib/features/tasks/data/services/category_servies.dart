import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:advanced_to_do_list/features/tasks/data/models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _categoriesRef {
    final uid = _auth.currentUser?.uid ?? 'default_user';
    return _firestore.collection('users').doc(uid).collection('categories');
  }

  Stream<List<CategoryModel>> getUserCategories() {
    return _categoriesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CategoryModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addCategory({
    required String name,
    required String iconName,
    required int colorValue,
  }) async {
    final docId = _categoriesRef.doc().id;

    final newCategory = CategoryModel(
      id: docId,
      name: name,
      iconName: iconName,
      colorValue: colorValue,
    );

    await _categoriesRef.doc(docId).set(newCategory.toMap());
  }

  Future<void> deleteCategory(String categoryId) async {
    await _categoriesRef.doc(categoryId).delete();
  }
}
