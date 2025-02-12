import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginsupabase/auth/auth_gate.dart';
import 'package:loginsupabase/screen/login_screen.dart';
import 'package:loginsupabase/screen/phonelogin_screen.dart';
import 'package:loginsupabase/screen/upload_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqZ3N3cXB6anpld2puc254YnhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg3NzM1OTksImV4cCI6MjA1NDM0OTU5OX0.9yV4Ja7hNkhRhusi-GeVUHxbLrljYfSwgiYkmwok1cg",
    url: "https://qjgswqpzjzewjnsnxbxf.supabase.co",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.light(primary: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
