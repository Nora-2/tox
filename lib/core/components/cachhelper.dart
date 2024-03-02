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
//      FirebaseFirestore.instance
//     .collection('history')
//     .get()
//     .then((QuerySnapshot querySnapshot) {
//   querySnapshot.docs.forEach((doc) {
//     History.add(doc['id']== FirebaseAuth.instance.currentUser!.uid?doc:null);
//     print(doc.data());
//   });
// });
  QuerySnapshot quarysnapshot = await FirebaseFirestore.instance
        .collection('history')
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    History.addAll(quarysnapshot.docs);

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
