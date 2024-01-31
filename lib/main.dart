import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_app/Features/settings/presentation/view/aboutus.dart';
import 'package:sports_app/core/components/homelayout.dart';
import 'package:sports_app/core/constants/constants.dart';

int? isViewed;
Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isViewed = prefs.getInt('onBoard');

  runApp(const SportsApp());
}

class SportsApp extends StatelessWidget {
  const SportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: const AppBarTheme(
              titleTextStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
      home: const HomeLayout(),
    );
  }
}
