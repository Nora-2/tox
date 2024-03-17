// ignore_for_file: must_be_immutable, avoid_print
import 'package:Toxicon/Features/Authantication/signin/login_cubit/login_cubit.dart';
import 'package:Toxicon/Features/home/cubit_home/homecubit_cubit.dart';
import 'package:Toxicon/Features/liver/cubit/livercubit_cubit.dart';
import 'package:Toxicon/Features/molecule/cubit/molecule_cubit.dart';
import 'package:Toxicon/Features/mutagenicity/cubit/dna_cubit.dart';
import 'package:Toxicon/Features/smilarty/cubit/smilarty_cubit.dart';
import 'package:Toxicon/core/config/helper/cachhelper.dart';
import 'package:Toxicon/core/config/cubit/app_cubit.dart';
import 'package:Toxicon/core/config/cubit/blocopserver.dart';
import 'package:Toxicon/core/config/Route/app_routes.dart';
import 'package:Toxicon/core/config/firebase/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  isViewed = prefs.getInt('onBoard');
  await CacheHelper.init();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  var isDarkFromShared = CacheHelper.getBoolean(key: 'isDark');
  Bloc.observer = MyBlocObserver();
  runApp(DevicePreview( 
    enabled: true, 
    builder: (context) => Toxicon(isDarkFromShared) 
  )); 
}

class Toxicon extends StatelessWidget {
  final bool? isDark;
  const Toxicon(this.isDark, {super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()..changemode(fromShared: isDark),
          ),
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => HomecubitCubit(),
          ),
          BlocProvider(
            create: (context) => LivercubitCubit(),
          ),
          BlocProvider(
            create: (context) => DnaCubit(),
          ),
          BlocProvider(
            create: (context) => MoleculeCubit(),
          ),
          BlocProvider(
            create: (context) => SmilartyCubit(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
            
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: AppCubit.get(context).isdark
                    ? Brightness.dark
                    : Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: AppCubit.get(context).isdark
                    ? Brightness.dark
                    : Brightness.light,
              ),
              themeMode: AppCubit.get(context).isdark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              initialRoute: AppRoutes.initialRoute,
              routes: AppRoutes.routes,
            );
          },
        ));
  }
}
