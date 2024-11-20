class User {
  static const String collectionName = 'Users';
  final String id;
  final String email;
  final String name;
  User({
    required this.id,
    required this.name,
    required this.email,
  });
  Map<String, dynamic> toFirestore() {
    return {
      'Id': id,
      'Name': name,
      'Email': email,
    };
  }

  factory User.fromFirestore(Map<String, dynamic>? data) {
    return User(
      id: data?['Id'],
      name: data?['Name'],
      email: data?['Email'],
    );
  }
}
