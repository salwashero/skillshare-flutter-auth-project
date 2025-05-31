// main.dart - الملف الرئيسي لتطبيق المدونة
import 'package:flutter/material.dart';
import 'screens/blog_list_screen.dart';
import 'models/blog_post.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // عنوان التطبيق
      title: 'تطبيق المدونة',
      
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
        
        // تخصيص البطاقات
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        
        // تخصيص أزرار التطبيق
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      
      // منع تدوير الشاشة (اختياري)
      debugShowCheckedModeBanner: false,
      
      // الشاشة الرئيسية للتطبيق (شاشة قائمة المدونات)
      home: const BlogListScreen(),
    );
  }
}
