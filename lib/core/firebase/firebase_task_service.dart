import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTaskService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> createTask(Map<String, dynamic> data) async {
    await _db.collection("tasks").doc(data["id"]).set(data);
  }

  static Stream<QuerySnapshot> getTasks() {
    return _db.collection("tasks").snapshots();
  }

  static Future<void> updateTask(String id, Map<String, dynamic> data) async {
    await _db.collection("tasks").doc(id).update(data);
  }

  static Future<void> deleteTask(String id) async {
    await _db.collection("tasks").doc(id).delete();
  }
}