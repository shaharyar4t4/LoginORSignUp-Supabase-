import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  // sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(email: email, password: password);
  }

// Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

// sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

// Get user Email
  String? getCurrenUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
  // Get the user auth by the phone number
  Future<void> signInWithPhone(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
    } catch (e) {
      throw Exception('Error sending OTP: $e');
    }
  }

  Future<void> verifyOTP(String phone, String otp) async {
    try {
      await _supabase.auth.verifyOTP(phone: phone, token: otp, type: OtpType.sms);
    } catch (e) {
      throw Exception('Error verifying OTP: $e');
    }
  }
}

