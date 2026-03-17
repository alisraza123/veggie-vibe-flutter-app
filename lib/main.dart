import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const VeggieVibe());
}

class VeggieVibe extends StatelessWidget {
  const VeggieVibe({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'VeggieVibe',
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
