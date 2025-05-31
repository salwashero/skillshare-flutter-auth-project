// main.dart - الملف الرئيسي للتطبيق
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // عنوان التطبيق
      title: 'تطبيق تسجيل الدخول',
      
      // تعريف سمة التطبيق (الألوان والخطوط)
      theme: ThemeData(
        // اللون الرئيسي للتطبيق
        primarySwatch: Colors.deepPurple,
        
        // اللون الثانوي
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF03DAC5),
        ),
        
        // خط التطبيق
        fontFamily: 'Roboto',
        
        // تخصيص أزرار التطبيق
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        
        // تخصيص حقول الإدخال
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
      
      // منع تدوير الشاشة (اختياري)
      debugShowCheckedModeBanner: false,
      
      // الشاشة الرئيسية للتطبيق (شاشة تسجيل الدخول)
      home: const LoginScreen(),
    );
  }
}
