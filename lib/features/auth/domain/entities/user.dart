/// LEARNING NOTES:
/// Responsible for: business rules and use-cases.
/// NOT allowed to: know about Dio, Flutter widgets, or databases.
/// 
/// PURPOSE: A plain Dart class representing the core User entity. No JSON here.
class User {
  final int id;
  final String email;
  final String name;

  const User({
    required this.id,
    required this.email,
    required this.name,
  });
}
