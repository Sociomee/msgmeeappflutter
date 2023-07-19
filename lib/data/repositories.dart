final String baseUrl = 'https://msgmee-node-docker-w0fh.onrender.com';

abstract class AuthRepository {
  Future<bool> sendOtp(String phone);
  Future<bool> verifyOtp(String phone, String otp);
  Future<bool> createUser(String phone, String name);
}
