// class UserData {
//   final String id;
//   final String username;
//   final String email;
//   final String createdAt;

//   UserData({
//     required this.id,
//     required this.username,
//     required this.email,
//     required this.createdAt,
//   });

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};
  
//     result.addAll({'id': id});
//     result.addAll({'username': username});
//     result.addAll({'email': email});
//     result.addAll({'createdAt': createdAt});
  
//     return result;
//   }

//   factory UserData.fromMap(Map<String, dynamic> map, documentId) {
//     return UserData(
//       id: documentId,
//       username: map['username'] ?? '',
//       email: map['email'] ?? '',
//       createdAt: map['createdAt'] ?? '',
//     );
//   }
// }

class UserData {
  final String id;
  final String username;
  final String email;
  final String createdAt;

  UserData({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'createdAt': createdAt
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map, String id) {
    return UserData(
      id: id,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  // إضافة copyWith للسهولة
  UserData copyWith({
    String? id,
    String? username,
    String? email,
    String? createdAt,
  }) {
    return UserData(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'UserData(id: $id, username: $username, email: $email, createdAt: $createdAt)';
  }
}