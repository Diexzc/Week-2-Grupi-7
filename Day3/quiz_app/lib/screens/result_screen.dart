import 'package:flutter/material.dart';
import 'quiz_screen.dart';

/// Ekrani i rezultatit që shfaqet pas përfundimit të quiz-it.
///
/// Merr [score] dhe [totalQuestions] si parametra.
/// Përdor [Navigator] për të rikthyer përdoruesin te quiz-i (restart).
class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _countController;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _countController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Fillo animacionet me vonesë të vogël
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _scaleController.forward();
        _countController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _countController.dispose();
    super.dispose();
  }

  /// Përqindja e suksesit
  double get _percentage => (widget.score / widget.totalQuestions) * 100;

  /// Kthen mesazhin bazuar në rezultat
  String get _resultMessage {
    if (_percentage == 100) return 'Perfekt! 🏆';
    if (_percentage >= 80) return 'Shkëlqyeshëm! 🌟';
    if (_percentage >= 60) return 'Shumë mirë! 👏';
    if (_percentage >= 40) return 'Jo keq! 💪';
    return 'Provo përsëri! 📚';
  }

  /// Kthen ngjyrën bazuar në rezultat
  Color get _resultColor {
    if (_percentage >= 80) return const Color(0xFF00C853);
    if (_percentage >= 60) return const Color(0xFFFFD700);
    if (_percentage >= 40) return const Color(0xFFFF9800);
    return const Color(0xFFFF5252);
  }

  /// Emoji bazuar në rezultat
  String get _resultEmoji {
    if (_percentage == 100) return '🏆';
    if (_percentage >= 80) return '🌟';
    if (_percentage >= 60) return '👍';
    if (_percentage >= 40) return '🤔';
    return '📖';
  }

  /// Rinis quiz-in duke naviguar prapa me Navigator.
  void _restartQuiz() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const QuizScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final contentWidth = isDesktop ? 500.0 : screenWidth;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F0C29),
              Color(0xFF302B63),
              Color(0xFF24243E),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 32.0 : 24.0,
                  vertical: 32.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildResultIcon(),
                    const SizedBox(height: 32),
                    _buildResultMessage(),
                    const SizedBox(height: 40),
                    _buildScoreCard(),
                    const SizedBox(height: 20),
                    _buildStatsRow(),
                    const SizedBox(height: 48),
                    _buildRestartButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Ndërton ikonën e animuar të rezultatit.
  Widget _buildResultIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              _resultColor.withOpacity(0.3),
              _resultColor.withOpacity(0.05),
            ],
          ),
          border: Border.all(
            color: _resultColor.withOpacity(0.5),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: _resultColor.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            _resultEmoji,
            style: const TextStyle(fontSize: 56),
          ),
        ),
      ),
    );
  }

  /// Ndërton mesazhin e rezultatit.
  Widget _buildResultMessage() {
    return Column(
      children: [
        Text(
          _resultMessage,
          style: TextStyle(
            color: _resultColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Quiz u përfundua!',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  /// Ndërton kartën e rezultatit me numër të animuar.
  Widget _buildScoreCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: _resultColor.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Rezultati juaj',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _countController,
            builder: (context, child) {
              final animatedScore =
                  (_countController.value * widget.score).round();
              final animatedPercentage =
                  (_countController.value * _percentage).round();
              return Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$animatedScore',
                          style: TextStyle(
                            color: _resultColor,
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' / ${widget.totalQuestions}',
                          style: const TextStyle(
                            color: Colors.white38,
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Progress ring vizual
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: _countController.value *
                                (widget.score / widget.totalQuestions),
                            strokeWidth: 8,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(_resultColor),
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        Text(
                          '$animatedPercentage%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Ndërton rreshtin e statistikave.
  Widget _buildStatsRow() {
    final correctAnswers = widget.score;
    final wrongAnswers = widget.totalQuestions - widget.score;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_outline,
            label: 'Saktë',
            value: '$correctAnswers',
            color: const Color(0xFF00C853),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.cancel_outlined,
            label: 'Gabim',
            value: '$wrongAnswers',
            color: const Color(0xFFFF5252),
          ),
        ),
      ],
    );
  }

  /// Ndërton një kartë statistike individuale.
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// Ndërton butonin e restart.
  Widget _buildRestartButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _restartQuiz,
            icon: const Icon(Icons.replay_rounded, size: 24),
            label: const Text(
              'Fillo Përsëri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              shadowColor: const Color(0xFF6C63FF).withOpacity(0.4),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: _restartQuiz,
          child: Text(
            'Provoni me pyetje të tjera herën tjetër! 🎯',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
