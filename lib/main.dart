import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regwalls/views/home.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
    ));
    return MaterialApp(
      title: 'RegWalls',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      home: const Home(),
    );
  }
}
