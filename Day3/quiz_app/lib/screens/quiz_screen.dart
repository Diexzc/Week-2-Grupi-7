import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';
import 'result_screen.dart';

/// Ekrani kryesor i quiz-it ku shfaqen pyetjet dhe opsionet.
///
/// Menaxhon state-in e pyetjes aktuale dhe pikëve me [setState].
/// Përdor [Navigator] për të kaluar te ekrani i rezultatit.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  /// Indeksi i pyetjes aktuale
  int _currentQuestionIndex = 0;

  /// Numri i përgjigjeve të sakta
  int _score = 0;

  /// Indeksi i opsionit të zgjedhur (-1 = asnjë)
  int _selectedOptionIndex = -1;

  /// Nëse përdoruesi ka konfirmuar përgjigjen
  bool _hasAnswered = false;

  /// Controller për animacionin e tranzicionit
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }


  /// Pyetja aktuale nga lista
  Question get _currentQuestion => quizQuestions[_currentQuestionIndex];

  /// Numri total i pyetjeve
  int get _totalQuestions => quizQuestions.length;

  /// Progresi si përqindje (0.0 - 1.0)
  double get _progress => (_currentQuestionIndex + 1) / _totalQuestions;

  /// Trajton zgjedhjen e një opsioni.
  void _selectOption(int index) {
    if (_hasAnswered) return;
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  /// Konfirmon përgjigjen dhe shton pikë nëse e saktë.
  void _confirmAnswer() {
    if (_selectedOptionIndex == -1 || _hasAnswered) return;

    setState(() {
      _hasAnswered = true;
      if (_currentQuestion.isCorrect(_selectedOptionIndex)) {
        _score++;
      }
    });

    // Prit pak para se të kalojmë te pyetja tjetër
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      _goToNextQuestion();
    });
  }

  /// Kalon te pyetja tjetër ose te ekrani i rezultatit.
  void _goToNextQuestion() {
    if (_currentQuestionIndex < _totalQuestions - 1) {
      // Animate out, then change question, then animate in
      _fadeController.reverse().then((_) {
        if (!mounted) return;
        setState(() {
          _currentQuestionIndex++;
          _selectedOptionIndex = -1;
          _hasAnswered = false;
        });
        _fadeController.forward();
      });
    } else {
      // Navigon te ekrani i rezultatit me Navigator
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ResultScreen(score: _score, totalQuestions: _totalQuestions),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.3),
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
  }

  /// Kthen ngjyrën e opsionit bazuar në gjendjen.
  Color _getOptionColor(int index) {
    if (!_hasAnswered) {
      return _selectedOptionIndex == index
          ? const Color(0xFF6C63FF)
          : Colors.transparent;
    }

    // Pas përgjigjes, tregon saktë/gabim
    if (index == _currentQuestion.correctAnswerIndex) {
      return const Color(0xFF00C853); // E gjelbër për saktë
    }
    if (index == _selectedOptionIndex) {
      return const Color(0xFFFF5252); // E kuqe për gabim
    }
    return Colors.transparent;
  }

  /// Kthen ngjyrën e tekstit të opsionit.
  Color _getOptionTextColor(int index) {
    if (!_hasAnswered && _selectedOptionIndex == index) {
      return Colors.white;
    }
    if (_hasAnswered &&
        (index == _currentQuestion.correctAnswerIndex ||
            index == _selectedOptionIndex)) {
      return Colors.white;
    }
    return Colors.white70;
  }

  /// Kthen ikonën e statusit pas përgjigjes.
  Widget? _getOptionIcon(int index) {
    if (!_hasAnswered) return null;

    if (index == _currentQuestion.correctAnswerIndex) {
      return const Icon(Icons.check_circle, color: Colors.white, size: 24);
    }
    if (index == _selectedOptionIndex &&
        index != _currentQuestion.correctAnswerIndex) {
      return const Icon(Icons.cancel, color: Colors.white, size: 24);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final contentWidth = isDesktop ? 600.0 : screenWidth;

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
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 32.0 : 20.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildProgressBar(),
                      const SizedBox(height: 32),
                      _buildQuestionCard(),
                      const SizedBox(height: 24),
                      Expanded(child: _buildOptions()),
                      _buildConfirmButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Ndërton header-in me numrin e pyetjes dhe pikët.
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Pyetja ${_currentQuestionIndex + 1}/$_totalQuestions',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF6C63FF).withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars_rounded, color: Color(0xFFFFD700), size: 20),
              const SizedBox(width: 6),
              Text(
                '$_score pikë',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Ndërton progress bar-in e animuar.
  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: _progress),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6C63FF),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${(_progress * 100).toInt()}%',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Ndërton kartën e pyetjes me efekt glassmorphism.
  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.quiz_rounded,
              color: Color(0xFF6C63FF),
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _currentQuestion.questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /// Ndërton listën e opsioneve.
  Widget _buildOptions() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: _currentQuestion.options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final optionLabel = String.fromCharCode(65 + index); // A, B, C, D
        return _buildOptionTile(index, optionLabel);
      },
    );
  }

  /// Ndërton një opsion individual.
  Widget _buildOptionTile(int index, String label) {
    final isSelected = _selectedOptionIndex == index;
    final bgColor = _getOptionColor(index);
    final textColor = _getOptionTextColor(index);
    final icon = _getOptionIcon(index);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectOption(index),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected && !_hasAnswered
                    ? const Color(0xFF6C63FF)
                    : Colors.white.withOpacity(0.15),
                width: isSelected && !_hasAnswered ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected && !_hasAnswered
                        ? Colors.white.withOpacity(0.2)
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    _currentQuestion.options[index],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (icon != null) icon,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Ndërton butonin e konfirmimit.
  Widget _buildConfirmButton() {
    final isEnabled = _selectedOptionIndex != -1 && !_hasAnswered;

    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.4,
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: isEnabled ? _confirmAnswer : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF6C63FF).withOpacity(0.3),
          disabledForegroundColor: Colors.white38,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: isEnabled ? 8 : 0,
          shadowColor: const Color(0xFF6C63FF).withOpacity(0.4),
        ),
        child: Text(
          _hasAnswered ? 'Duke kaluar...' : 'Konfirmo Përgjigjen',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
