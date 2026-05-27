import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryEntry {
  final String  id;
  final String  text;
  final DateTime date;
  final String? imageUrl;
  final String  mood;  // emoji: 😊 😐 😢 😡 🤩

  const DiaryEntry({
    required this.id,
    required this.text,
    required this.date,
    this.imageUrl,
    this.mood = '😊',
  });

  // Converte DocumentSnapshot do Firestore para DiaryEntry
  factory DiaryEntry.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return DiaryEntry(
      id:       doc.id,
      text:     d['text']     as String,
      date:     (d['date']    as Timestamp).toDate(),
      imageUrl: d['imageUrl'] as String?,
      mood:     d['mood']     as String? ?? '😊',
    );
  }

  // Converte DiaryEntry para Map (para salvar no Firestore)
  Map<String, dynamic> toFirestore() => {
    'text':     text,
    'date':     Timestamp.fromDate(date),
    'imageUrl': imageUrl,
    'mood':     mood,
  };

  DiaryEntry copyWith({String? text, String? imageUrl, String? mood}) =>
      DiaryEntry(
        id:       id,
        text:     text     ?? this.text,
        date:     date,
        imageUrl: imageUrl ?? this.imageUrl,
        mood:     mood     ?? this.mood,
      );
}