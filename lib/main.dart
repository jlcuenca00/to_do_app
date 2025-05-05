import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(

        primaryColor: const Color(0xFF00438A), 
        primaryColorLight: const Color(0xFF8DC2E8),
        primaryColorDark: const Color(0xFF003070),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF00438A),
          secondary: const Color(0xFFDC1E35),
          tertiary: const Color(0xFF8DC2E8), 
          background: Colors.white,
        ),
      ),
    );
  }
}
