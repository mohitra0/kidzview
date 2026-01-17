import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webportal/pages/pitch_presentation.dart';
import 'package:webportal/pages/quotation_page.dart';
import 'package:webportal/demo_portal/demo_persona_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const QuotationPage(),
        '/quotation': (context) => const QuotationPage(),
        '/demo': (context) => const DemoPersonaPage(),
        '/presentation': (context) => const PitchPresentationPage(schoolName: 'MCP School', numStudents: 100),
      },
    );
  }
}

