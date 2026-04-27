class RegisteredUser {
  const RegisteredUser({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory RegisteredUser.fromJson(Map<String, dynamic> json) {
    return RegisteredUser(
      name: (json['name'] as String? ?? '').trim(),
      email: (json['email'] as String? ?? '').trim(),
    );
  }
}
