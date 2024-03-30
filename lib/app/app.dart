import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magic_project/app/feat/splash/splash_screen.dart';
import 'package:magic_project/app/feat/web_view/cubits/web_view_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WebViewCubit>(
      create: (context) => WebViewCubit()..loadUrl("https://xiaomicheck.com/"),
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Xiaomi Imei Checker',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: const SplashScreen(),
              )),
    );
  }
}
