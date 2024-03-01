import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
   static  List data = [];
 static getdata() async {
  QuerySnapshot quarysnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
  data.addAll(quarysnapshot.docs);
}
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future<void> setBoolean({
    required String key,
    required bool value,
  }) async =>
      await sharedPreferences.setBool(key, value);

  static bool? getBoolean({required String key}) => sharedPreferences.getBool(key);
 

}