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

  Future getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('userId') ?? 0;
  }

  Future setUserId(int userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('userId', userId);
  }

  Future getCurrentRoomId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('currentRoomId') ?? 0;
  }

  Future setCurrentRoomId(int currentRoomId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('currentRoomId', currentRoomId);
  }
}