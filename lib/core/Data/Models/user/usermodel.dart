import 'package:flutter/foundation.dart';

class User implements Comparable {
  String userId;
  String name;
  String email;
  String password;
  String? phone;
  String? date;
  String? jop;
  String? country;
  List<dynamic>? history;
  dynamic image;

  User(
      {this.jop,
      this.phone,
      this.country,
      required this.userId,
       this.image,
      required this.name,
      required this.email,
      required this.password,
      this.date,
      this.history});

  factory User.fromJson(Map<String, Object?> json) => User(
        userId: json["userId"] as String,
        name: json["name"] as String,
        email: json["email"] as String,
        jop: json["jop"] as String,
        phone: json["phone"] as String,
        country: json["country"] as String,
        password: json["password"] as String,
        date: json["date"] as String,
        image: json["image"] as List<Uint8List>,
        // cards: json["cards"] as List<int>,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        'phone': phone,
        'jop': jop,
        'country': country,
        'date': date,
        'image':image
      };

  @override
  String toString() {
    return 'User{id: $userId,image:$image, name: $name, email: $email,date: $date, password: $password, country: $country,jop: $jop,phone: $phone,}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          date == other.date &&
          phone == other.phone &&
          jop == other.jop &&
          image == other.image &&
          country == other.country;

  @override
  int get hashCode {
    return Object.hash(
        userId, name, email, password, country, jop, phone, date,image);
  }

  @override
  int compareTo(other) {
    return name.compareTo(other.name);
  }
}
