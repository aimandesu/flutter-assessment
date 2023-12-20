class Contact {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;
  int favourite;

  Contact({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
    required this.favourite
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "first_name": first_name,
      "last_name": last_name,
      "avatar": avatar,
      "favourite": favourite,
    };
  }
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      email: map['email'],
      first_name: map['first_name'],
      last_name: map['last_name'],
      avatar: map['avatar'],
      favourite: 0,
    );
  }
}
