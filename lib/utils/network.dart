import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/user.dart';

class Network extends NetworkNormal {
  // change NetworkNormal to NetworkDemo or NetworkDemoError to test without a server
}

class NetworkNormal {
  final _host = 'http://10.0.2.2:3000';

  Future<Room> fetchRoom(int roomId) async {
    final response = await http.get('$_host/room/$roomId', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return Room.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room. Error: ${response.statusCode}');
    }
  }

  Future<List<Room>> fetchAllRooms() async {
    final response = await http.get('$_host/room', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new Room.fromJson(m)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room. Error: ${response.statusCode}');
    }
  }

  Future<Room> createRoom(Room room) async {
    final response = await http.post(
        '$_host/room',
        body: json.encode(room),
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return Room.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room. Error: ${response.statusCode}');
    }
  }

  // TODO: send user data with join request
  Future<Room> joinRoom(int roomId, User participant) async {
//    final response = await http.post(
//        '$_host/room/$roomId/participant',
//        body: json.encode(participant),
//        headers: {"Content-Type": "application/json"})
//        .timeout(Duration(milliseconds: 5000));

    final response = await http.get('$_host/room/$roomId', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return Room.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room. Error: ${response.statusCode}');
    }
  }
}

class NetworkDemo {
  final delay = const Duration(milliseconds: 500);

  Future<Room> fetchRoom(int roomId) async {
    await Future.delayed(delay);
    return Room.fromJson(json.decode('{"roomId": 42, "topic": "Topic ${Random().nextInt(9001)}", "meetingPoint": "Skyscraper"}'));
  }

  Future<List<Room>> fetchAllRooms() async {
    await Future.delayed(delay);
    List responseJson = json.decode('[{"roomId": 42, "topic": "Topic ${Random().nextInt(9001)}", "meetingPoint": "Skyscraper"}, '
        '{"roomId": 84, "topic": "Mobile Programming", "meetingPoint": "Cafeteria"}]');
    return responseJson.map((m) => new Room.fromJson(m)).toList();
  }

  Future<Room> createRoom(Room room) async {
    await Future.delayed(delay);
    room.roomId = Random().nextInt(9001);
    return room;
  }
}

class NetworkDemoError {
  final delay = const Duration(milliseconds: 1000);

  Future<Room> fetchRoom(int roomId) async {
    await Future.delayed(delay);
    throw Exception('Failed to load room. Error: ${404}');
  }

  Future<List<Room>> fetchAllRooms() async {
    await Future.delayed(delay);
    throw Exception('Failed to load room. Error: ${404}');
  }

  Future<Room> createRoom(Room room) async {
    await Future.delayed(delay);
    throw Exception('Failed to load room. Error: ${404}');
  }
}