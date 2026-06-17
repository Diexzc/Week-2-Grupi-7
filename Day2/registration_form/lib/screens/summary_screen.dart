import 'package:flutter/material.dart';
import '../models/registration_data.dart';

/// Ekrani i përfundimit (summary) që shfaqet pas regjistrimit të suksesshëm.
///
/// Merr [RegistrationData] dhe shfaq detajet e regjistrimit.
/// Përdor [Navigator.pop] për tu kthyer te forma.
class SummaryScreen extends StatefulWidget {
  final RegistrationData data;

  const SummaryScreen({super.key, required this.data});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Maskon email-in për siguri vizuale.
  String get _maskedEmail {
    final parts = widget.data.email.split('@');
    if (parts.length != 2) return widget.data.email;
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return widget.data.email;
    return '${name.substring(0, 2)}${'•' * (name.length - 2)}@$domain';
  }

  /// Maskon fjalëkalimin.
  String get _maskedPassword => '•' * widget.data.password.length;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final contentWidth = isDesktop ? 480.0 : screenWidth;

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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40.0 : 24.0,
                  vertical: 32.0,
                ),
                child: Column(
                  children: [
                    _buildSuccessIcon(),
                    const SizedBox(height: 28),
                    _buildSuccessMessage(),
                    const SizedBox(height: 36),
                    _buildDetailsCard(),
                    const SizedBox(height: 32),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Ikona e suksesit me animacion.
  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [
              Color(0xFF00E676),
              Color(0xFF00C853),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E676).withOpacity(0.35),
              blurRadius: 40,
              spreadRadius: 8,
            ),
          ],
        ),
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 56,
        ),
      ),
    );
  }

  /// Mesazhi i suksesit.
  Widget _buildSuccessMessage() {
    return Column(
      children: [
        const Text(
          'Regjistrimi u krye! 🎉',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Llogaria juaj u krijua me sukses',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  /// Karta me detajet e regjistrimit.
  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detajet e Regjistrimit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            icon: Icons.person_rounded,
            label: 'Emri',
            value: widget.data.name,
            color: const Color(0xFF7C4DFF),
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.email_rounded,
            label: 'Email',
            value: _maskedEmail,
            color: const Color(0xFF448AFF),
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.lock_rounded,
            label: 'Fjalëkalimi',
            value: _maskedPassword,
            color: const Color(0xFFFF9800),
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.badge_rounded,
            label: 'Roli',
            value: widget.data.role,
            color: const Color(0xFF00E676),
          ),
        ],
      ),
    );
  }

  /// Ndërton një rresht detaji.
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Ndarësi vizual.
  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.06),
      height: 1,
    );
  }

  /// Butonat e veprimeve.
  Widget _buildActions() {
    return Column(
      children: [
        // Butoni kryesor — kthehu te forma
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigator.pop kthehet te forma e regjistrimit
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded, size: 20),
            label: const Text(
              'Kthehu te Forma',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C4DFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: const Color(0xFF7C4DFF).withOpacity(0.4),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Tekst informues
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF00E676).withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF00E676).withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: const Color(0xFF00E676).withOpacity(0.7),
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Një email konfirmimi u dërgua te ${widget.data.email}',
                  style: TextStyle(
                    color: const Color(0xFF00E676).withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
