class UserResponse {
  final String name;
  final String email;

  UserResponse({required this.name, required this.email});

  factory UserResponse.fromFirestore(Map<String, dynamic> json) {
    return UserResponse(name: json['name'] ?? '', email: json['email'] ?? '');
  }
}
