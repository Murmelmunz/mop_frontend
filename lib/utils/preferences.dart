import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('userName') ?? 'Anonymous';
  }

  Future setUserName(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userName', userName);
  }
}