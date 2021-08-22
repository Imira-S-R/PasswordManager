final String tableNotes = 'passwords';

class PasswordFields {
  static final List<String> values = [
    /// Add all fields
    id, title, username, password
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String username = 'description';
  static final String password = 'password';
}

class Password {
  final int? id;
  final String title;
  final String username;
  final String password;

  const Password({
    this.id,
    required this.title,
    required this.username,
    required this.password,
  });

  Password copy({
    int? id,
    String? title,
    String? username,
    String? password,
  }) =>
      Password(
        id: id ?? this.id,
        title: title ?? this.title,
        username: username ?? this.username,
        password: password ?? this.password,
      );

  static Password fromJson(Map<String, Object?> json) => Password(
        id: json[PasswordFields.id] as int?,
        title: json[PasswordFields.title] as String,
        username: json[PasswordFields.username] as String,
        password: json[PasswordFields.password] as String,
      );

  Map<String, Object?> toJson() => {
        PasswordFields.id: id,
        PasswordFields.title: title,
        PasswordFields.username: username,
        PasswordFields.password: password
      };
}
