import 'package:flutter/material.dart';
import 'package:loginsupabase/auth/auth_services.dart';
import 'package:loginsupabase/screen/sigup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    //setup the Login
    void login() async {
      final Email = email.text;
      final password = pass.text;

      try {
        await _authServices.signInWithEmailAndPassword(Email, password);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error: $e")));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Login",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login to your account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20,),
          ListView(
            shrinkWrap: true,
            children: [
              // email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Your Email",
                      label: Text("Email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              // password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Your Password",
                      label: Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              // login button
              ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  "login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SigupScreen()));
                    },
                    child: Text("Dont have an account? SignUp")),
              )
            ],
          ),
        ],
      ),
    );
  }
}
