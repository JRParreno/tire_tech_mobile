import 'package:tire_tech_mobile/features/account/signup/data/models/signup.dart';

abstract class SignupRepository {
  Future<Map<String, dynamic>> register(Signup signup);
  Future<Map<String, dynamic>> generateOTP(String userId);
  Future<Map<String, dynamic>> verifyOTP({
    required String userId,
    required String otp,
  });
}
