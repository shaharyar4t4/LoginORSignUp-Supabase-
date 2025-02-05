/*
*
* AUTH GATE - This will continously listen for auth state changes
*
* -----------------------------------------------------------------
* unauthenticated  => login page
* authenticated    => home page
*
**/

import 'package:flutter/material.dart';
import 'package:loginsupabase/screen/login_screen.dart';
import 'package:loginsupabase/screen/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // Listen to auth state changes
        stream: Supabase.instance.client.auth.onAuthStateChange,

        // Build appropriate page based on auth state
        builder: (context, snapshot) {
          //loading.... screen shows
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // check if there is a valid session currently
          final  session = snapshot.hasData ? snapshot.data!.session : null;
          if (session != null){
            return ProfileScreen();
          }else {
            return LoginScreen();
          }

        });
  }
}
