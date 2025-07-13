import 'package:flutter/material.dart';
import 'package:notes_app/addnotes.dart';
import 'package:notes_app/home.dart';
void main() {
      
      runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // لإزالة شريط "debug"
      title: 'Notes App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF007ACC), // ← لون الخلفية
          foregroundColor: Colors.white, // ← لون النص والأيقونات
           // ← العنوان في المنتصف دائمًا
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 2, // ← ظل خفيف تحت AppBar
        )
      ),
      home: Home(), // هنا تربط الصفحة الرئيسية
      routes: {"addnotes":(context) => Addnotes() },
    );
  }
}
