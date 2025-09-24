import 'package:cbt_tpa_fic17_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  // simpan data lokal
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', data.toJson());
  }

  // hapus data lokal
  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('auth_data');
  }

  // get data lokal
  Future<AuthResponseModel?> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('auth_data');
    if (data != null) {
      return AuthResponseModel.fromJson(data);
    } else {
      throw Exception('auth data not found');
    }
  }

  // cek data lokal
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('auth_data');
  }
}
