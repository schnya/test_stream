import 'package:cloud_firestore/cloud_firestore.dart';

class CounterRef {
  DocumentReference<Map<String, dynamic>> ref;

  CounterRef({required this.ref});

  Future<void> update(Map<String, Object?> data) async {
    await ref.update(data);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> get snapshots =>
      ref.snapshots();

  Future<DocumentSnapshot<Map<String, dynamic>>> get() => ref.get();
}
