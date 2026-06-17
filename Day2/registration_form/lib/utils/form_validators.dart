/// Funksionet e validimit për fushat e formës.
///
/// Çdo funksion kthen [null] nëse vlera është e vlefshme,
/// ose një mesazh gabimi nëse nuk është.
class FormValidators {
  /// Gjatësia minimale e fjalëkalimit.
  static const int minPasswordLength = 8;

  /// Validon emrin — duhet të ketë të paktën 2 karaktere.
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Emri është i detyrueshëm';
    }
    if (value.trim().length < 2) {
      return 'Emri duhet të ketë të paktën 2 karaktere';
    }
    return null;
  }

  /// Validon email-in me RegExp.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email-i është i detyrueshëm';
    }

    // Pattern bazë për validimin e email-it
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Shkruani një email të vlefshëm';
    }
    return null;
  }

  /// Validon fjalëkalimin — minimumi 8 karaktere.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Fjalëkalimi është i detyrueshëm';
    }
    if (value.length < minPasswordLength) {
      return 'Fjalëkalimi duhet të ketë të paktën $minPasswordLength karaktere';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Duhet të përmbajë të paktën një shkronjë të madhe';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Duhet të përmbajë të paktën një numër';
    }
    return null;
  }

  /// Validon konfirmimin e fjalëkalimit.
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Konfirmoni fjalëkalimin';
    }
    if (value != password) {
      return 'Fjalëkalimet nuk përputhen';
    }
    return null;
  }

  /// Validon rolin — duhet të zgjedhet një.
  static String? validateRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zgjidhni një rol';
    }
    return null;
  }
}
