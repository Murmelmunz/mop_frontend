import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:speechlist/models/contribution.dart';
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
      throw Exception('Failed to load rooms. Error: ${response.statusCode}');
    }
  }

  Future<Room> createRoom(Room room) async {
    print("${json.encode(room)}");
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
      throw Exception('Failed to create room. Error: ${response.statusCode}');
    }
  }

  Future<List<User>> fetchRoomParticipants(Room room) async {
    final response = await http.get('$_host/room/${room.roomId}/participant', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new User.fromJson(m)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room participants. Error: ${response.statusCode}');
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
      throw Exception('Failed to join room. Error: ${response.statusCode}');
    }
  }

  Future<List<Contribution>> fetchRoomContributions(Room room) async {
    final response = await http.get('$_host/room/${room.roomId}/contribution', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new Contribution.fromJson(m)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room contributions. Error: ${response.statusCode}');
    }
  }

  // TODO: send contribution data
  Future<Contribution> createRoomContribution(Room room, Contribution contribution) async {
//    final response = await http.post(
//        '$_host/room/${room.roomId}/contribution',
//        body: json.encode(contribution),
//        headers: {"Content-Type": "application/json"})
//        .timeout(Duration(milliseconds: 5000));

    final response = await http.get('$_host/room/${room.roomId}', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return Contribution.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to create contribution. Error: ${response.statusCode}');
    }
  }
}

class NetworkDemo {
  final delay = const Duration(milliseconds: 500);

  Future<Room> fetchRoom(int roomId) async {
    await Future.delayed(delay);
    return Room.fromJson(json.decode(
      '''
        {
          "roomId": 42, 
          "topic": "Topic ${Random().nextInt(9001)}",
          "meetingPoint": "Skyscraper",
          "categories": [
            {
              "name": "Gender",
              "values": [
                {"value": "Masculine"},
                {"value": "Feminine"}
              ]
            },
            {
              "name": "Haircolor",
              "values": [
                {"value": "Red"},
                {"value": "Green"},
                {"value": "Blue"}
              ]
            }
          ]
        }
      '''
    ));
  }

  Future<List<Room>> fetchAllRooms() async {
    await Future.delayed(delay);
    List responseJson = json.decode(
      '''
        [
          {
            "roomId": 42, 
            "topic": "Topic ${Random().nextInt(9001)}",
            "meetingPoint": "Skyscraper",
            "categories": [
              {
                "name": "Gender",
                "values": [
                  {"value": "Masculine"},
                  {"value": "Feminine"}
                ]
              },
              {
                "name": "Haircolor",
                "values": [
                  {"value": "Red"},
                  {"value": "Green"},
                  {"value": "Blue"}
                ]
              }
            ]
          },
          {
            "roomId": 84, 
            "topic": "Mobile Programming",
            "meetingPoint": "Cafeteria",
            "categories": [
              {
                "name": "Category1",
                "values": [
                  {"value": "Value1"},
                  {"value": "Value2"},
                  {"value": "Value3"}
                ]
              },
              {"name": "Category2"},
              {"name": "Category3"},
              {"name": "Category4"},
              {"name": "Category5"}
            ]
          }
        ]
      '''
    );
    return responseJson.map((m) => new Room.fromJson(m)).toList();
  }

  Future<Room> createRoom(Room room) async {
    print(json.encode(room));
    await Future.delayed(delay);
    room.roomId = Random().nextInt(9001);
    return room;
  }



  Future<List<Contribution>> fetchRoomContributions(Room room) async {
    await Future.delayed(delay);
    List responseJson = json.decode('[{"id": 0, "type": "contribution", "userId": 1337}, '
        '{"id": 1, "type": "question", "userId": 1337}]');
    return responseJson.map((m) => new Contribution.fromJson(m)).toList();
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
    throw Exception('Failed to load rooms. Error: ${404}');
  }

  Future<Room> createRoom(Room room) async {
    print(json.encode(room));
    await Future.delayed(delay);
    throw Exception('Failed to create room. Error: ${404}');
  }
}