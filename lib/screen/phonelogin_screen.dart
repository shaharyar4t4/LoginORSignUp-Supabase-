import 'package:flutter/material.dart';
import '../auth/auth_services.dart';
import 'profile_screen.dart';

class phoneLoginScreen extends StatefulWidget {
  @override
  _phoneLoginScreenState createState() => _phoneLoginScreenState();
}

class _phoneLoginScreenState extends State<phoneLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final AuthServices _authServices = AuthServices();
  bool isOtpSent = false;

  void sendOTP() async {
    try {
      await _authServices.signInWithPhone(phoneController.text.trim());
      setState(() => isOtpSent = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
  }

  void verifyOTP() async {
    try {
      await _authServices.verifyOTP(phoneController.text.trim(), otpController.text.trim());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            if (isOtpSent)
              TextField(
                controller: otpController,
                decoration: InputDecoration(labelText: 'Enter OTP'),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isOtpSent ? verifyOTP : sendOTP,
              child: Text(isOtpSent ? 'Verify OTP' : 'Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
