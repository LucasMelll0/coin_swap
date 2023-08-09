import 'package:coin_swap/theme/color_schemes.g.dart';
import 'package:coin_swap/ui/converter.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true),
      home: const CurrencyConverterPage(),
    );
  }
}


