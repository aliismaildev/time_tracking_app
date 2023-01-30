import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/core/viewmodels/home_viewmodel.dart';
import 'package:time_tracking_app/views/auth/login_view.dart';
import 'package:time_tracking_app/views/auth/register_view.dart';
import 'package:time_tracking_app/views/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModelModel>(create: (_) => HomeViewModelModel()),
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
        initialRoute: LoginView.routeName,
        // initialRoute: PlayerDetailView.routeName,
        routes: {
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
