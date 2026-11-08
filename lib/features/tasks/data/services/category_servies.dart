import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';

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
    final category = CategoryModel(
      id: docId,
      name: name,
      iconName: iconName,
      colorValue: colorValue,
    );

    await _categoriesRef.doc(docId).set(category.toMap());
  }

 
  Future<void> addDefaultCategoriesIfNeeded() async {
    final snapshot = await _categoriesRef.get();
    if (snapshot.docs.isEmpty) {
      await addCategory(
          name: 'Work', iconName: 'work', colorValue: Colors.blue.value);
      await addCategory(
          name: 'Personal',
          iconName: 'person',
          colorValue: Colors.deepOrange.value);
      await addCategory(
          name: 'Shopping',
          iconName: 'shopping',
          colorValue: Colors.amber.value);
      await addCategory(
          name: 'Health',
          iconName: 'health',
          colorValue: Colors.redAccent.value);
      await addCategory(
          name: 'Study',
          iconName: 'study',
          colorValue: Colors.blueAccent.value);
    }
  }
}
