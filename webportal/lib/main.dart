import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webportal/pages/pitch_presentation.dart';
import 'package:webportal/pages/quotation_page.dart';
import 'signin/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'KidzView',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1f2937)),
          useMaterial3: true,
          textTheme: GoogleFonts.spaceGroteskTextTheme(),
        ),
        home: const QuotationPage());
  }
}
