import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.blueAccent, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  'Darti Kaciu',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'ICT Student / Developer',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(color: Colors.grey),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    const Icon(Icons.email, color: Colors.blueAccent),
                    const SizedBox(width: 15.0),
                    Text(
                      'dk231@bgt.school',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Colors.blueAccent),
                    const SizedBox(width: 15.0),
                    Text(
                      '+383 49 123 456',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Builder(
                  builder: (context) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact info copied to clipboard!'),
                          backgroundColor: Colors.blueAccent,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text('Contact Me'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
