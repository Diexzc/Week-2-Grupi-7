import 'package:flutter/material.dart';
import '../models/registration_data.dart';
import '../utils/form_validators.dart';
import 'summary_screen.dart';

/// Ekrani kryesor i formës së regjistrimit.
///
/// Përdor [Form] me [GlobalKey<FormState>] për validim.
/// Menaxhon state-in e fushave me [TextEditingController].
/// Shfaq mesazhe gabimi inline pa e prishur layout-in.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  /// Çelësi global për validimin e formës
  final _formKey = GlobalKey<FormState>();

  /// Controllers për fushat e tekstit
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  /// Roli i zgjedhur
  String? _selectedRole;

  /// Nëse fjalëkalimi është i dukshëm
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  /// Nëse forma po dërgohet (loading state)
  bool _isSubmitting = false;

  /// Lista e roleve të mundshme
  static const List<String> _roles = [
    'Student',
    'Zhvillues',
    'Dizajner',
    'Menaxher',
    'Tjetër',
  ];

  /// Nëse forma u tentua të paktën një herë (për auto-validim)
  bool _autoValidate = false;

  /// Controller për animacionin
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();

    // Dëgjon ndryshimet e fjalëkalimit për indikatorin e forcës
    _passwordController.addListener(() => setState(() {}));
  }


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  /// Trajton dërgimin e formës.
  ///
  /// Validon të gjitha fushat, simulon dërgesë me vonesë,
  /// pastaj navigon te [SummaryScreen] me [Navigator].
  Future<void> _submitForm() async {
    // Aktivizo auto-validimin pas tentativës së parë
    setState(() => _autoValidate = true);

    if (!_formKey.currentState!.validate()) return;

    // Simulon dërgimin (p.sh. API call)
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    // Krijo objektin me të dhënat
    final registrationData = RegistrationData(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      role: _selectedRole!,
    );

    // Navigo te ekrani i përfundimit
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SummaryScreen(data: registrationData),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final contentWidth = isDesktop ? 520.0 : screenWidth;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0A1A),
              Color(0xFF1A1035),
              Color(0xFF0D1B2A),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 40.0 : 24.0,
                    vertical: 32.0,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 36),
                        _buildFormCard(),
                        const SizedBox(height: 24),
                        _buildSubmitButton(),
                        const SizedBox(height: 16),
                        _buildFooterText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Ndërton header-in me ikonë dhe titull.
  Widget _buildHeader() {
    return Column(
      children: [
        // Ikona e regjistrimit
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF7C4DFF), Color(0xFF448AFF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Krijoni Llogarinë',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Plotësoni fushat për tu regjistruar',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  /// Ndërton kartën kryesore me të gjitha fushat.
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fusha e emrit
          _buildSectionLabel('Emri i plotë', Icons.person_outline),
          const SizedBox(height: 8),
          _buildNameField(),

          const SizedBox(height: 20),

          // Fusha e email-it
          _buildSectionLabel('Email', Icons.email_outlined),
          const SizedBox(height: 8),
          _buildEmailField(),

          const SizedBox(height: 20),

          // Fusha e fjalëkalimit
          _buildSectionLabel('Fjalëkalimi', Icons.lock_outline),
          const SizedBox(height: 8),
          _buildPasswordField(),

          const SizedBox(height: 20),

          // Konfirmimi i fjalëkalimit
          _buildSectionLabel('Konfirmo fjalëkalimin', Icons.lock_reset),
          const SizedBox(height: 8),
          _buildConfirmPasswordField(),

          const SizedBox(height: 20),

          // Zgjedhja e rolit
          _buildSectionLabel('Roli / Statusi', Icons.badge_outlined),
          const SizedBox(height: 8),
          _buildRoleDropdown(),
        ],
      ),
    );
  }

  /// Ndërton etiketën e seksionit.
  Widget _buildSectionLabel(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF7C4DFF), size: 18),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  /// Stilon InputDecoration për të gjitha fushat.
  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.25)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF7C4DFF), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFFF5252), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFFF5252), width: 1.5),
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFFF8A80),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      errorMaxLines: 2,
      suffixIcon: suffixIcon,
    );
  }

  /// Fusha e emrit.
  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: _inputDecoration(hint: 'Shkruani emrin tuaj'),
      validator: FormValidators.validateName,
    );
  }

  /// Fusha e email-it.
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: _inputDecoration(hint: 'email@shembull.com'),
      validator: FormValidators.validateEmail,
    );
  }

  /// Fusha e fjalëkalimit me toggle visibiliteti.
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          style: const TextStyle(color: Colors.white, fontSize: 15),
          decoration: _inputDecoration(
            hint: 'Minimum ${FormValidators.minPasswordLength} karaktere',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: Colors.white38,
                size: 20,
              ),
              onPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
          ),
          validator: FormValidators.validatePassword,
        ),
        const SizedBox(height: 8),
        // Indikatori i forcës së fjalëkalimit
        _buildPasswordStrength(),
      ],
    );
  }

  /// Ndërton indikatorin vizual të forcës së fjalëkalimit.
  Widget _buildPasswordStrength() {
    final password = _passwordController.text;
    int strength = 0;
    String label = '';
    Color color = Colors.transparent;

    if (password.isNotEmpty) {
      if (password.length >= 8) strength++;
      if (password.contains(RegExp(r'[A-Z]'))) strength++;
      if (password.contains(RegExp(r'[0-9]'))) strength++;
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

      switch (strength) {
        case 0:
        case 1:
          label = 'E dobët';
          color = const Color(0xFFFF5252);
          break;
        case 2:
          label = 'Mesatare';
          color = const Color(0xFFFF9800);
          break;
        case 3:
          label = 'E fortë';
          color = const Color(0xFFFFD740);
          break;
        case 4:
          label = 'Shumë e fortë';
          color = const Color(0xFF00E676);
          break;
      }
    }

    return AnimatedOpacity(
      opacity: password.isNotEmpty ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 3,
                  margin: EdgeInsets.only(right: index < 3 ? 6 : 0),
                  decoration: BoxDecoration(
                    color: index < strength
                        ? color
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          if (password.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Fusha e konfirmimit të fjalëkalimit.
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: !_isConfirmPasswordVisible,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: _inputDecoration(
        hint: 'Rishkruani fjalëkalimin',
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: Colors.white38,
            size: 20,
          ),
          onPressed: () {
            setState(
                () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
          },
        ),
      ),
      validator: (value) =>
          FormValidators.validateConfirmPassword(value, _passwordController.text),
    );
  }

  /// Dropdown për zgjedhjen e rolit.
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      dropdownColor: const Color(0xFF1A1035),
      icon: const Icon(Icons.expand_more_rounded, color: Colors.white38),
      decoration: _inputDecoration(hint: 'Zgjidhni rolin tuaj'),
      items: _roles.map((role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (value) {
        setState(() => _selectedRole = value);
      },
      validator: FormValidators.validateRole,
    );
  }

  /// Butoni i dërgimit me loading state.
  Widget _buildSubmitButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 56,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: _isSubmitting ? 0 : 8,
          shadowColor: const Color(0xFF7C4DFF).withOpacity(0.4),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isSubmitting
                  ? [
                      const Color(0xFF7C4DFF).withOpacity(0.4),
                      const Color(0xFF448AFF).withOpacity(0.4),
                    ]
                  : [
                      const Color(0xFF7C4DFF),
                      const Color(0xFF448AFF),
                    ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            alignment: Alignment.center,
            child: _isSubmitting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.how_to_reg_rounded,
                          color: Colors.white, size: 22),
                      SizedBox(width: 10),
                      Text(
                        'Regjistrohu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  /// Teksti në fund.
  Widget _buildFooterText() {
    return Center(
      child: Text(
        'Duke u regjistruar, ju pranoni kushtet e përdorimit.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withOpacity(0.3),
          fontSize: 12,
        ),
      ),
    );
  }
}
