import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мій профіль'), backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.blue, width: 3),
                ),
                child: const Icon(Icons.person, size: 50,),
              ),
              const SizedBox(width: 20,),
              const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Сергій Колесников', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8,),
                      Text('Вік: 34 років'),
                    ],
                  ),
              ),
            ],),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/contacts'),
                  child: const Text('Контакти', style: TextStyle(fontSize: 20, color:  Colors.black),),
              ),
            )
          ],
        ),
      ),
    );
  }

}