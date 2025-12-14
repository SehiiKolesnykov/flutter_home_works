import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../providers/providers.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _nameController = TextEditingController();
  String _frequency = 'Щодня';
  DateTime _startDate = DateTime.now();

  final List<String> frequencies = ['Щодня', 'Кожні 2 дні', 'Раз на тиждень', 'Раз на місяць'];

  void _addHabit() {
    final user = ref.read(authStateProvider).value;
    if (user == null || _nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Введіть назву')));
      return;
    }

    final habit = Habit(
      id: '',
      name: _nameController.text.trim(),
      frequency: _frequency,
      startDate: _startDate,
      progress: {},
      userId: user.uid,
    );

    ref.read(firestoreServiceProvider).addHabit(habit);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Звичку додано!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Нова звичка')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Назва звички',
                hintText: 'Наприклад: Ранкова пробіжка',
                prefixIcon: const Icon(Icons.flag_outlined),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _frequency,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    dropdownColor: Colors.indigo,
                    items: frequencies.map((freq) => DropdownMenuItem(value: freq, child: Text(freq))).toList(),
                    onChanged: (value) => setState(() => _frequency = value!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.white),
                title: const Text('Дата початку', style: TextStyle(color: Colors.white)),
                subtitle: Text(DateFormat('dd MMMM yyyy', 'uk').format(_startDate), style: const TextStyle(color: Colors.white70)),
                trailing: const Icon(Icons.edit_calendar, color: Colors.white),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: Theme.of(context).colorScheme), child: child!),
                  );
                  if (date != null) setState(() => _startDate = date);
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _addHabit,
                child: const Text('Додати звичку', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}