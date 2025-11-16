import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Work 05',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Homework'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget buildImage(String url) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.network(url, width: 200, height: 200, fit: BoxFit.cover,),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFE8D2FF),

      appBar: AppBar(
        backgroundColor: Color(0xFFE8D2FF),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            const Text('Beautiful Images',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            buildImage(
                'https://fastly.picsum.photos/id/179/2048/1365.jpg?hmac=GJyDjrvfBfjPfJPqSBd2pX6sjvsGbG10d21blr5bTS8',
            ),

            const SizedBox(height: 16),

            buildImage(
                'https://fastly.picsum.photos/id/200/1920/1280.jpg?hmac=-eKjMC8-UrbLMpy1A4OWrK0feVPB3Ka5KNOGibQzpRU'
            ),

            const SizedBox(height: 20),

            const Text(
              'My text',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'My favorite animal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset('assets/images/hedgehog.jpg', width: 400, height: 220, fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
      )
    );
  }
}
