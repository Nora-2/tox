// ignore_for_file: must_be_immutable

import 'package:Toxicon/Features/Authantication/signin/login_cubit/login_cubit.dart';
import 'package:Toxicon/Features/home/cubit_home/homecubit_cubit.dart';
import 'package:Toxicon/Features/liver/cubit/livercubit_cubit.dart';
import 'package:Toxicon/Features/molecule/cubit/molecule_cubit.dart';
import 'package:Toxicon/Features/mutagenicity/cubit/dna_cubit.dart';
import 'package:Toxicon/Features/smilarty/cubit/smilarty_cubit.dart';
import 'package:Toxicon/core/components/cachhelper.dart';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:Toxicon/core/components/cubit/blocopserver.dart';
import 'package:Toxicon/core/utils/app_routes.dart';
import 'package:Toxicon/core/utils/homeutilis.dart';
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
  await CacheHelper.init();
  var isDarkFromShared = CacheHelper.getBoolean(key: 'isDark');
  Bloc.observer = MyBlocObserver();
  runApp(Toxicon(isDarkFromShared));
}

class Toxicon extends StatelessWidget {
   final bool? isDark;
   Toxicon(this.isDark, {super.key});
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
