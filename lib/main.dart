import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/components/homelayout.dart';
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
                primaryColor: AppCubit().isdark
                    ? const Color(0xff0D0D0D)
                    : const Color.fromARGB(179, 204, 122, 0),
                brightness: AppCubit.get(context).isdark
                    ? Brightness.dark
                    : Brightness.light,
              ),
              darkTheme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: AppCubit.get(context).isdark
                      ? const Color(0xff0D0D0D)
                      : const Color.fromARGB(179, 204, 122, 0),
                ),
                iconTheme: IconThemeData(
                  color: AppCubit().isdark
                      ?const Color.fromARGB(179, 204, 122, 0):const Color(0xff0D0D0D)
                      
                ),
                brightness: AppCubit.get(context).isdark
                    ? Brightness.dark
                    : Brightness.light,
              ),
              themeMode: AppCubit.get(context).isdark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const HomeLayout(),
            );
          },
        ));
  }
}
