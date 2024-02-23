import 'package:Toxicon/core/Data/Models/user/usermodel.dart';

User? currentUser;

final user1 = User(
  userId: "0",
  name: "Bruno Fernandes",
  email: "bruno@gmail.com",
  password: "a",
phone: '0288939020',
country: 'emarat',
jop: 'engineer',
  history: [],
);
final user2 = User(
  userId: "1",
  name: "Nora Mohamed",
  email: "Nora@gmail.com",
  password: "nora",
  phone: '01026076471',
country: 'Egypt',
jop: 'Reasercher',
date: '12/12/2001',
  history: [],

);

final usersList = <User>[
  user1,
  user2,
];
