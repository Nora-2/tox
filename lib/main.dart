import 'package:Toxicon/Features/liver/liver.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: AppCubit.get(context).isdark?Brightness.dark:Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: AppCubit.get(context).isdark?Brightness.dark:Brightness.light,
              ),
              themeMode: AppCubit.get(context).isdark?ThemeMode.dark:ThemeMode.light,
              home: const LiverScreen(),
            );
          },
        ));
  }
}
