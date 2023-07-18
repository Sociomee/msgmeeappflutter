final String baseUrl = 'https://msgmee-node-docker-w0fh.onrender.com';

abstract class AuthRepository {
  Future<bool> sendOtp(String phone);
  Future<void> verigyOtp();
}
