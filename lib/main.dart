import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/core/viewmodels/auth_viewmodel.dart';
import 'package:time_tracking_app/core/viewmodels/home_viewmodel.dart';
import 'package:time_tracking_app/firebase_options.dart';
import 'package:time_tracking_app/views/auth/login_view.dart';
import 'package:time_tracking_app/views/auth/register_view.dart';
import 'package:time_tracking_app/views/home/home_view.dart';
import 'package:time_tracking_app/views/onboarding/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Returns an instance of the binding that implements WidgetsBinding. If no binding has yet been initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //Initializes a new FirebaseApp instance by name and options and returns the created app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        title: Lang.timeTrackingApp,
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //     primaryColor: AppColors.primary,
        //     primaryColorDark: AppColors.primarySwatch,
        //     primaryColorLight: AppColors.primaryLight,
        //     // scaffoldBackgroundColor: AppColors.whiteColor,
        //     appBarTheme: const AppBarTheme(
        //       backgroundColor: AppColors.primary,
        //       elevation: 0.0,
        //     ),
        //     colorScheme: ColorScheme.fromSwatch()
        //         .copyWith(secondary: AppColors.accent)
        //         .copyWith(secondary: AppColors.accent)),
        navigatorKey: navigate,
        // initialRoute: read.currentUser != null ? HomeView.routeName : LoginView.routeName,
        initialRoute: SplashView.routeName,
        // initialRoute: PlayerDetailView.routeName,
        routes: {
          SplashView.routeName: (context) => const SplashView(),
          HomeView.routeName: (context) => const HomeView(),
          LoginView.routeName: (context) => const LoginView(),
          RegisterView.routeName: (context) => const RegisterView(),
        },
      ),
    );
  }
}

//Global key for context
GlobalKey<NavigatorState> navigate = GlobalKey<NavigatorState>();
