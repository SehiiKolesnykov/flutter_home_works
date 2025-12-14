import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw_12/models/habit.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final firestoreServiceProvider = Provider<FirestoreService>((ref) => FirestoreService());


final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});


final currentUserProvider = Provider<User?>((ref) {
  return FirebaseAuth.instance.currentUser;
});

final habitsProvider = StreamProvider<List<Habit>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user != null) {
    return ref.watch(firestoreServiceProvider).getHabits(user.uid);
  }
  return Stream.value([]);
});