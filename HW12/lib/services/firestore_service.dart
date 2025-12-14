import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/habit.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  Future<void> addHabit(Habit habit) async {
    String id = _uuid.v4();
    await _db.collection('habits').doc(id).set(habit.toFirestore());
  }

  Stream<List<Habit>> getHabits(String userId) {
    return _db.collection('habits')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Habit.fromFirestore(doc)).toList());
  }

  Future<void> updateProgress(String habitId, String date, bool completed) async {
    await _db.collection('habits').doc(habitId).update({
      'progress.$date': completed,
    });
  }
}