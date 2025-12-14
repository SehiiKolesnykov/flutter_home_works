import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import '../providers/providers.dart';
import '../widgets/habit_card.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final firestore = ref.read(firestoreServiceProvider);
    final auth = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мої звички', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Text('Ще немає звичок', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  const Text('Натисни + щоб додати першу!'),
                ],
              ),
            );
          }

          return MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return HabitCard(
                habit: habit,
                onTap: () => Navigator.pushNamed(context, '/habit_details', arguments: habit),
                onToggleComplete: (habitId, completed) {
                  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
                  firestore.updateProgress(habitId, today, completed);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (_, __) => const Center(child: Text('Помилка', style: TextStyle(color: Colors.redAccent))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_habit'),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: auth.logout,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
          child: const Text('Вийти', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}