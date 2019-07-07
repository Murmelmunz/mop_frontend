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

//class Preferences {
//  String userName = 'Anonymous';
//  int userId = 0;
//  int currentRoomId = 0;
//
//  static final Preferences _singleton = Preferences._internal();
//
//  factory Preferences() {
//    return _singleton;
//  }
//
//  Preferences._internal();
//
//  Future getUserName() async {
//    return userName;
//  }
//
//  Future setUserName(String userName) async {
//    this.userName = userName;
//  }
//
//  Future getUserId() async {
//    return userId;
//  }
//
//  Future setUserId(int userId) async {
//    this.userId = userId;
//  }
//
//  Future getCurrentRoomId() async {
//    return currentRoomId;
//  }
//
//  Future setCurrentRoomId(int currentRoomId) async {
//    this.currentRoomId = currentRoomId;
//  }
//}