import 'package:flutter/material.dart';
import 'package:loginsupabase/auth/auth_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  final AuthServices _authServices = AuthServices();

  void logout() async {
    await _authServices.signOut();
  }

  Widget build(BuildContext context) {
    final currentUserEmail = _authServices.getCurrenUserEmail();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Text(
        currentUserEmail.toString(),
        style: TextStyle(fontSize: 16),
      )),
    );
  }
}
