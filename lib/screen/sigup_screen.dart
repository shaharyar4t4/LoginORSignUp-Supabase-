import 'package:flutter/material.dart';
import 'package:loginsupabase/auth/auth_services.dart';
import 'package:loginsupabase/screen/login_screen.dart';

class SigupScreen extends StatefulWidget {
  const SigupScreen({super.key});

  @override
  State<SigupScreen> createState() => _SigupScreenState();
}

class _SigupScreenState extends State<SigupScreen> {
  final TextEditingController emailsig = TextEditingController();
  final TextEditingController passsig = TextEditingController();
  final TextEditingController confrimpass = TextEditingController();
  final AuthServices _authServices = AuthServices();

  //setup the Login
  void SignUp() async {
    final Email = emailsig.text;
    final password = passsig.text;
    final confirmPassword = confrimpass.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: Password don't match")));
      return;
    }
    try {
      await _authServices.signUpWithEmailAndPassword(Email, password);
      Navigator.pop(context);
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Sigup",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          // email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: emailsig,
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
              obscureText: true,
              controller: passsig,
              decoration: InputDecoration(
                  hintText: "Your Password",
                  label: Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: TextField(
              controller: confrimpass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Your confirm Password",
                  label: Text("Confrim Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          // Sign Up button
          ElevatedButton(
            onPressed: () {
              SignUp();
            },
            child: Text(
              "Sign Up",
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
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Already have an account? Login")),
          )
        ],
      ),
    );
  }
}
