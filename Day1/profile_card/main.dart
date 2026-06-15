import 'package:flutter/material.dart';




void main() => runApp(const MyApp());




class MyApp extends StatelessWidget {
  const MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const ProfileScreen(),
    );
  }
}




class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar icon
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.person, size: 56, color: Colors.white),
                ),
                const SizedBox(height: 16),




                // Name
                const Text(
                  'Diellart Zeka',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),




                // Role
                const Text(
                  'Flutter Intern',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),




                // Contact info row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email, color: Colors.indigo, size: 18),
                    SizedBox(width: 8),
                    Text('diellartzeka@email.com'),
                  ],
                ),
                const SizedBox(height: 8),




                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone, color: Colors.indigo, size: 18),
                    SizedBox(width: 8),
                    Text('+383 49 554 112'),
                  ],
                ),
                const SizedBox(height: 24),




                // Button
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact request sent!'),
                        backgroundColor: Colors.indigo,
                      ),
                    );
                  },
                  icon: const Icon(Icons.connect_without_contact),
                  label: const Text('Contact Me'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
  import 'package:flutter/material.dart';




void main() => runApp(const MyApp());




class MyApp extends StatelessWidget {
  const MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const ProfileScreen(),
    );
  }
}




class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar icon
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.person, size: 56, color: Colors.white),
                ),
                const SizedBox(height: 16),




                // Name
                const Text(
                  'Diellart Zeka',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),




                // Role
                const Text(
                  'Flutter Intern',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),




                // Contact info row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email, color: Colors.indigo, size: 18),
                    SizedBox(width: 8),
                    Text('diellartzeka@email.com'),
                  ],
                ),
                const SizedBox(height: 8),




                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone, color: Colors.indigo, size: 18),
                    SizedBox(width: 8),
                    Text('+383 49 554 112'),
                  ],
                ),
                const SizedBox(height: 24),




                // Button
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact request sent!'),
                        backgroundColor: Colors.indigo,
                      ),
                    );
                  },
                  icon: const Icon(Icons.connect_without_contact),
                  label: const Text('Contact Me'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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


                  ),
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



