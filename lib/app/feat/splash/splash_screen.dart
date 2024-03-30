import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import 'package:magic_project/app/feat/web_view/cubits/web_view_cubit.dart';
import 'package:magic_project/app/feat/web_view/cubits/web_view_state.dart';

import '../web_view/presentation/screens/web_view_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  bool _isDisposed = false;

  _SplashScreenState() {
    Timer(
      const Duration(milliseconds: 3000),
      () async {
        if (_isDisposed) return; // Check if the widget has been disposed

        if (!_isDisposed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocBuilder<WebViewCubit, WebViewState>(
                builder: (context, state) {
                  var cubit = context.watch<WebViewCubit>();
                  if (state is WebViewSuccessState) {
                    return WebViewScreen(
                      controller: cubit.controller,
                      appBarTitle: 'Mi Imei Checker',
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    ); // Placeholder while loading
                  }
                },
              ),
            ),
          );
        }
      },
    );

    Timer(const Duration(milliseconds: 10), () {
      if (!_isDisposed) {
        // Check before setting state
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true; // Set the flag when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/svg/magic.svg',
              fit: BoxFit.cover,
              width: 200.w,
              height: 400.h,
              colorFilter: const ColorFilter.mode(
                Colors.orange,
                BlendMode.srcIn,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0,
            duration: const Duration(milliseconds: 500),
          ),
        ],
      ),
    );
  }
}
