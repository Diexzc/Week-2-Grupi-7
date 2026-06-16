import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profiles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const StudentListScreen(),
    );
  }
}

// Student model
class Student {
  final String name;
  final String email;
  final String role;

  Student({required this.name, required this.email, required this.role});
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  // Error messages
  String nameError = '';
  String emailError = '';
  String roleError = '';

  // List of students
  List<Student> students = [
    Student(
        name: 'Filan Fisteku',
        email: 'filan@email.com',
        role: 'Flutter Intern'),
    Student(
        name: 'Arben Krasniqi', email: 'arben@email.com', role: 'Web Intern'),
  ];

  // Email validation function
  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  // Add student function
  void addStudent() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String role = roleController.text.trim();

    // Reset errors
    setState(() {
      nameError = '';
      emailError = '';
      roleError = '';
    });

    // Validate
    bool hasError = false;

    if (name.isEmpty) {
      setState(() => nameError = 'Name cannot be empty');
      hasError = true;
    }

    if (email.isEmpty) {
      setState(() => emailError = 'Email cannot be empty');
      hasError = true;
    } else if (!isValidEmail(email)) {
      setState(() => emailError = 'Enter a valid email');
      hasError = true;
    }

    if (role.isEmpty) {
      setState(() => roleError = 'Role cannot be empty');
      hasError = true;
    }

    if (hasError) return;

    // Add to list
    setState(() {
      students.add(Student(name: name, email: email, role: role));
      nameController.clear();
      emailController.clear();
      roleController.clear();
    });

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Student added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Student Profiles'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Form card
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add New Student',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Name field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.person),
                      errorText: nameError.isEmpty ? null : nameError,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Email field
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email),
                      errorText: emailError.isEmpty ? null : emailError,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Role field
                  TextField(
                    controller: roleController,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.work),
                      errorText: roleError.isEmpty ? null : roleError,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Add button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: addStudent,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Student'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // List of students
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text(
                        student.name[0], // first letter of name
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      student.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.email,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(student.email),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.work,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(student.role),
                          ],
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
