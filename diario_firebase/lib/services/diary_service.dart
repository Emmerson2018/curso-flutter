import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/diary_entry.dart';

class DiaryService {
  final _db      = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // Subcoleção isolada por usuário: /users/{uid}/entries
  CollectionReference _col(String uid) =>
      _db.collection('users').doc(uid).collection('entries');

  // Stream em tempo real — a UI atualiza quando o Firestore muda
  // Funciona offline: o Firestore cacheia os dados localmente
  Stream<List<DiaryEntry>> watchEntries(String uid) {
    return _col(uid)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(DiaryEntry.fromFirestore).toList());
  }

  Future<void> addEntry(String uid, DiaryEntry entry) =>
      _col(uid).add(entry.toFirestore());

  Future<void> updateEntry(String uid, DiaryEntry entry) =>
      _col(uid).doc(entry.id).update(entry.toFirestore());

  Future<void> deleteEntry(String uid, String id) =>
      _col(uid).doc(id).delete();

  // Faz upload de foto e retorna a URL pública de download
  Future<String> uploadImage(String uid, File file) async {
    final name = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref  = _storage.ref().child('diary/$uid/$name');
    final task = await ref.putFile(file);
    return task.ref.getDownloadURL();
  }
}