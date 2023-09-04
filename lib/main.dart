import 'package:flutter/material.dart';
import 'package:test_commerce/screens/main/home_screen.dart';
import 'package:test_commerce/screens/main_screen.dart';
import 'package:test_commerce/screens/splash_screen.dart';
import 'package:test_commerce/styles/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.cyan,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
