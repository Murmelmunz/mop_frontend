import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speechlist/models/room.dart';

class Network {
  final _host = 'http://10.0.2.2:3000';

  Future<Room> fetchRoom(int roomId) async {
    final response = await http.get('$_host/room/$roomId', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return Room.fromJSON(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room. Error: ${response.statusCode}');
    }
  }



  Future<Room> createRoom(Room room) async {
    room.roomId = new Random().nextInt(9000);
    final response = await http.post(
        '$_host/room',
        body: json.encode(room),
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
//      return Room.fromJSON(json.decode(response.body));
      return room;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room. Error: ${response.statusCode}');
    }
  }
}