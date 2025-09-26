import '../models/profile_model.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile);
}

class ProfileRemoteDataSourceImpl implements ProfileDataSource {
  @override
  Future<ProfileModel> getProfile() async {
    // Call API with Dio
    return ProfileModel(
      id: "1",
      name: "John Doe",
      email: "john@example.com",
      photoUrl: "https://example.com/profile.jpg",
    );
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    // Call API with Dio
    return profile;
  }
}
