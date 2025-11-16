import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final List<Map<String, String>> contacts = const [
    {'name': 'Світлана Колесникова', 'phone': '+38 (099) 999 99 99'},
    {'name': 'Іван Колесников', 'phone': '+38 (066) 666 66 66'},
    {'name': 'Денис Єгоров', 'phone': '+38 (050) 123 45 67'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Контакти'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: contacts.map((c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person_outline, color: Colors.blue),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(c['phone']!),
                    ],
                  ),
                ],
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }
}
