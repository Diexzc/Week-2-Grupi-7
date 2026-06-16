import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  final String name;
  final String email;
  final String role;
  final Color avatarColor;
  final Color avatarBg;
  final Color badgeBg;

  Student({
    required this.name,
    required this.email,
    this.role = 'Student',
    required this.avatarColor,
    required this.avatarBg,
    required this.badgeBg,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Profiles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1117),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00D9A6),
          surface: Color(0xFF1A1D27),
          error: Color(0xFFFF6B6B),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF14161E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          elevation: 8,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1A1D27),
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF22252F),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 14,
          ),
          errorStyle: const TextStyle(fontSize: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      home: const StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen>
    with SingleTickerProviderStateMixin {
  final List<Student> _students = [
    Student(
      name: 'Nils Shehu',
      email: 'nils.shehu@email.com',
      role: 'Flutter Developer',
      avatarColor: const Color(0xFF6C63FF),
      avatarBg: const Color(0xFF1A1740),
      badgeBg: const Color(0xFF141230),
    ),
    Student(
      name: 'Arta Krasniqi',
      email: 'arta.k@email.com',
      role: 'UI Designer',
      avatarColor: const Color(0xFF00D9A6),
      avatarBg: const Color(0xFF0A2A22),
      badgeBg: const Color(0xFF071F19),
    ),
    Student(
      name: 'Endrit Morina',
      email: 'endrit.m@email.com',
      role: 'Backend Developer',
      avatarColor: const Color(0xFFFF6B6B),
      avatarBg: const Color(0xFF2A1515),
      badgeBg: const Color(0xFF1F0F0F),
    ),
  ];

  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabController.forward();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  static const List<List<Color>> _colorSets = [
    [Color(0xFF6C63FF), Color(0xFF1A1740), Color(0xFF141230)],
    [Color(0xFF00D9A6), Color(0xFF0A2A22), Color(0xFF071F19)],
    [Color(0xFFFF6B6B), Color(0xFF2A1515), Color(0xFF1F0F0F)],
    [Color(0xFFFFB347), Color(0xFF2A2210), Color(0xFF1F1A0C)],
    [Color(0xFF4FC3F7), Color(0xFF102530), Color(0xFF0C1C24)],
    [Color(0xFFBA68C8), Color(0xFF241428), Color(0xFF1A0F1E)],
  ];

  Student _createStudent(String name, String email) {
    final colors = _colorSets[_students.length % _colorSets.length];
    return Student(
      name: name,
      email: email,
      avatarColor: colors[0],
      avatarBg: colors[1],
      badgeBg: colors[2],
    );
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[\w\.\-]+$');
    return regex.hasMatch(email);
  }

  void _showAddStudentSheet() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscurePassword = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF14161E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFF555555),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1B3D),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.person_add_rounded,
                              color: Color(0xFF6C63FF),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Shto Student',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: nameCtrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Emri i plote',
                          prefixIcon: Icon(Icons.person_outline_rounded,
                              color: Color(0xFF6C63FF)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Emri nuk mund te jete bosh';
                          }
                          if (value.trim().length < 2) {
                            return 'Emri duhet te kete te pakten 2 shkronja';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailCtrl,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined,
                              color: Color(0xFF6C63FF)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email nuk mund te jete bosh';
                          }
                          if (!_isValidEmail(value.trim())) {
                            return 'Formati i email-it nuk eshte valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordCtrl,
                        style: const TextStyle(color: Colors.white),
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Fjalekalimi',
                          prefixIcon: const Icon(Icons.lock_outline_rounded,
                              color: Color(0xFF6C63FF)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: const Color(0xFF888888),
                            ),
                            onPressed: () {
                              setSheetState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Fjalekalimi nuk mund te jete bosh';
                          }
                          if (value.length < 6) {
                            return 'Fjalekalimi duhet te kete te pakten 6 karaktere';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                _students.add(
                                  _createStudent(
                                    nameCtrl.text.trim(),
                                    emailCtrl.text.trim(),
                                  ),
                                );
                              });
                              Navigator.of(ctx).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${nameCtrl.text.trim()} u shtua me sukses!',
                                  ),
                                  backgroundColor: const Color(0xFF00D9A6),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.check_rounded),
                          label: const Text('Regjistro'),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _deleteStudent(int index) {
    final removed = _students[index];
    setState(() {
      _students.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed.name} u fshi'),
        backgroundColor: const Color(0xFFFF6B6B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'Kthe',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _students.insert(index, removed);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilet e Studenteve'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1B3D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_students.length} studente',
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _students.isEmpty ? _buildEmptyState() : _buildStudentList(),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(
          parent: _fabController,
          curve: Curves.easeOutBack,
        ),
        child: FloatingActionButton.extended(
          onPressed: _showAddStudentSheet,
          icon: const Icon(Icons.person_add_rounded),
          label: const Text('Shto'),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.group_off_rounded,
            size: 80,
            color: Color(0xFF333333),
          ),
          SizedBox(height: 16),
          Text(
            'Nuk ka studente',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Shtyp butonin + per te shtuar nje student',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 12, bottom: 88),
      itemCount: _students.length,
      itemBuilder: (context, index) {
        return StudentCard(
          student: _students[index],
          index: index,
          onDelete: () => _deleteStudent(index),
        );
      },
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student student;
  final int index;
  final VoidCallback onDelete;

  const StudentCard({
    super.key,
    required this.student,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Dismissible(
        key: ValueKey('${student.email}-$index'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF2A1515),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.delete_rounded,
            color: Color(0xFFFF6B6B),
            size: 28,
          ),
        ),
        onDismissed: (_) => onDelete(),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1D27),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF252830),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: student.avatarBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      student.initials,
                      style: TextStyle(
                        color: student.avatarColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        student.email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: student.badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    student.role,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: student.avatarColor,
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
