import 'package:tire_tech_mobile/features/account/profile/data/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> fetchProfile();
  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String contactNumber,
    required String gender,
  });
  Future<void> setPushToken(String token);
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });
  Future<void> uploadIds({
    required String pk,
    required String frontImagePath,
    required String backImagePath,
  });
  Future<String> uploadPhoto({
    required String pk,
    required String imagePath,
  });
}
