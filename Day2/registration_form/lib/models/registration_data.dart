/// Modeli i të dhënave të regjistrimit.
///
/// Ruan informacionin e përdoruesit pas validimit të suksesshëm.
class RegistrationData {
  final String name;
  final String email;
  final String password;
  final String role;

  const RegistrationData({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}
