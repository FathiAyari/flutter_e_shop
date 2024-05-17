class Cuser {
  String uid;
  String name;
  String lastName;
  String email;

  Cuser({
    required this.uid,
    required this.name,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'lastName': lastName,
      'email': email,
    };
  }

  factory Cuser.fromJson(Map<String, dynamic> json) {
    return Cuser(
      uid: json['uid'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }
}
