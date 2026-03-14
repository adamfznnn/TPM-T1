import 'package:flutter/material.dart';
// 1. Pastikan import ini tidak merah
import 'package:flutter_localizations/flutter_localizations.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Tugas Dart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Opsional: Agar tampilan lebih modern
      ),
      // 2. Localization Delegates harus di dalam MaterialApp
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'), // Bahasa Indonesia
        Locale('en', 'US'), // Bahasa Inggris
      ],
      // 3. Pastikan LoginPage sudah diimport di atas
      home: LoginPage(),
    );
  }
}
