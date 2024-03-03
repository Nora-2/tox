// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static List data = [];
  static getdata() async {
    QuerySnapshot quarysnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(quarysnapshot.docs);
  }

  static List History = [];
  static getdataHistory() async {

  QuerySnapshot quarysnapshot = await FirebaseFirestore.instance
        .collection('history')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    History.addAll(quarysnapshot.docs);

  }

 static CollectionReference users = FirebaseFirestore.instance.collection('users');

 static Future<void>? addUser({required name,required mobile,required jop,required country,required birth,required email,required url}) {
    return users
        // existing document in 'users' collection: "ABC123"
        .doc()
        .set(
          {
            'full_name': name.text == ''
                ? data.isNotEmpty ? data.last['full_name']
                : name.text:name.text,
            'phone':mobile.text==''?data.isNotEmpty ? data.last['phone'] :mobile.text:mobile.text,
            'company':jop.text==''?data.isNotEmpty ? data.last['company'] :jop.text:jop.text, // Stokes and Sons
            'country':country.text==''?data.isNotEmpty ? data.last['country'] :country.text:country.text,
            'birth': birth.text==''?data.isNotEmpty ? data.last['birth'] :birth.text:birth.text,
            'email': email.text == ''?data.isNotEmpty ? data.last['email'] :
                 FirebaseAuth.instance.currentUser!.email
                : email.text,
            'id': FirebaseAuth.instance.currentUser!.uid,
            'url': url ?? (data.isNotEmpty ? data.last['url'] :''),
          },
          SetOptions(merge: true),
        )
        .then(
            (value) => print("'full_name' & 'age' merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<void> setBoolean({
    required String key,
    required bool value,
  }) async =>
      await sharedPreferences.setBool(key, value);

  static bool? getBoolean({required String key}) =>
      sharedPreferences.getBool(key);



      
}

