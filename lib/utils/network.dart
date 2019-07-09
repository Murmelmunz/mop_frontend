import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:speechlist/models/contribution.dart';
import 'package:speechlist/models/evaluated_contribution.dart';
import 'dart:convert';
import 'package:speechlist/models/room.dart';
import 'package:speechlist/models/user.dart';

class Network extends NetworkNormal {
  // change NetworkNormal to NetworkDemo or NetworkDemoError to test without a server
}

class NetworkNormal {
  final _host = 'http://141.19.142.81:3000';

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
        .timeout(Duration(milliseconds: 15000));

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

  Future<User> joinRoom(int roomId, User participant) async {
    String body = '''
      {
        "user": 
        [
          {
            "name": "${participant.name}",
            "password": "${participant.password}",
            "roomPassword": "${participant.password}",
            
            "categories": ${json.encode(participant.categories)}
            
          }
        ]
      }
    ''';

    print(body);
    final response = await http.post(
        '$_host/room/$roomId/user',
        body: body,
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return User.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to join room. Error: ${response.statusCode}');
    }
  }

  Future<List<Contribution>> fetchRoomContributions(Room room) async {
    final response = await http.get('$_host/room/${room.roomId}/contributionsAll', headers: {"Content-Type": "application/json"})
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

  Future<Contribution> createRoomContribution(Room room, Contribution contribution, User user) async {
    String body = '''
      {
        "contribution": 
        [
          {
            "art": "${contribution.type}",
            "name": "${user.name}"
          }
        ]
      }
    ''';

    print(body);
    final response = await http.post(
        '$_host/room/${room.roomId}/user/${user.id}/contribution',
        body: body,
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      return Contribution.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to create contribution. Error: ${response.statusCode}');
    }
  }

  void removeRoomContribution(Room room, Contribution contribution, User user) async {
    String body = '''
      {
        "contribution": 
        [
          {
            "art": "${contribution.type}",
            "name": "${user.name}"
          }
        ]
      }
    ''';

    print('$_host/room/${room.roomId}/user/${user.id}/contribution/${contribution.id}');
    final response = await http.delete(
        '$_host/room/${room.roomId}/user/${user.id}/contribution/${contribution.id}',
//        body: body,
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

//    if (response.statusCode >= 200 && response.statusCode < 300) {
//      // If the call to the server was successful, parse the JSON
//      return Contribution.fromJson(json.decode(response.body));
//    } else {
//      // If that call was not successful, throw an error.
//      throw Exception('Failed to create contribution. Error: ${response.statusCode}');
//    }
  }

  void setRoomContributionStartTime(Room room, Contribution contribution, User user, DateTime timeStart) async {
    String body = '''
      {
        "timeStart": "$timeStart"
      }
    ''';

    print(body);
    final response = await http.post(
        '$_host/room/${room.roomId}/evaluation/${contribution.id}',
        body: body,
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));
  }

  void setRoomContributionStopTime(Room room, Contribution contribution, User user, DateTime timeStop) async {
    String body = '''
      {
        "timeStop": "$timeStop"
      }
    ''';

    print(body);
    final response = await http.post(
        '$_host/room/${room.roomId}/evaluation/${contribution.id}',
        body: body,
        headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));
  }

  Future<List<EvaluatedContribution>> fetchRoomEvaluation(int roomId) async {
    final response = await http.get('$_host/room/${roomId}/evaluation', headers: {"Content-Type": "application/json"})
        .timeout(Duration(milliseconds: 5000));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // If the call to the server was successful, parse the JSON
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new EvaluatedContribution.fromJson(m)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load room evaluation. Error: ${response.statusCode}');
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
    "_id": "5d0fe55ad7b9acd6a4f80602",
    "categories": [
        {
            "name": "Geschlecht",
            "values": [
                {
                    "value": "M"
                },
                {
                    "value": "W"
                }
            ]
        },
        {
            "name": "Haar",
            "values": [
                {
                    "value": "R"
                },
                {
                    "value": "G"
                },
                {
                    "value": "B"
                }
            ]
        }
    ],
    "contributionsAll": [
        {
            "art": "lib/assets/antwort_icon.png",
            "contributionId": 796109,
            "name": "Lisa",
            "userId": 898591
        },
        {
            "art": "lib/assets/antwort_icon.png",
            "contributionId": 123,
            "name": "Jonny",
            "userId": 343
        }
    ],
    "date": "27.06.19",
    "meetingPoint": "Hochhaus",
    "name": "Gehalt",
    "password": null,
    "roomId": 595557,
    "time": "5:46 PM",
    "user": [
        {
            "contribution": {
                "contribution": [
                    {
                        "art": "lib/assets/antwort_icon.png",
                        "contributionId": 602870,
                        "name": "Klaus"
                    },
                    {
                        "art": "lib/assets/rede_icon.png",
                        "contributionId": 88876,
                        "name": "Klaus"
                    }
                ]
            },
            "name": "Klaus",
            "password": "",
            "userId": 587127
        },
        {
            "contribution": {
                "contribution": [
                    {
                        "art": "lib/assets/fragezeichen_icon.png",
                        "contributionId": 756117,
                        "name": "Anonymousrtest3PPP"
                    }
                ]
            },
            "name": "Anonymousrtest3PPP",
            "password": "",
            "userId": 490249
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
        "_id": "5d0fe55ad7b9acd6a4f80602",
        "categories": [
            {
                "name": "Geschlecht",
                "values": [
                    {
                        "value": "M"
                    },
                    {
                        "value": "W"
                    }
                ]
            },
            {
                "name": "Haar",
                "values": [
                    {
                        "value": "R"
                    },
                    {
                        "value": "G"
                    },
                    {
                        "value": "B"
                    }
                ]
            }
        ],
        "date": "27.06.19",
        "meetingPoint": "Hochhaus",
        "name": "Gehalt",
        "password": null,
        "roomId": 595557,
        "time": "5:46 PM",
        "user": [
            {
                "contribution": {
                    "contribution": [
                        {
                            "art": "lib/assets/fragezeichen_icon.png",
                            "contributionId": 602870,
                            "name": "Klaus"
                        },
                        {
                            "art": "lib/assets/rede_icon.png",
                            "contributionId": 88876,
                            "name": "Klaus"
                        }
                    ]
                },
                "name": "Klaus",
                "password": "",
                "userId": 587127
            },
            {
                "contribution": {
                    "contribution": [
                        {
                            "art": "lib/assets/rede_icon.png",
                            "contributionId": 756117,
                            "name": "Anonymousrtest3PPP"
                        }
                    ]
                },
                "name": "Anonymousrtest3PPP",
                "password": "",
                "userId": 490249
            }
        ]
    },
    {
        "_id": "5d0fec65d7b9acd6a4f8061f",
        "categories": [
            {
                "name": "Cat1",
                "values": [
                    {
                        "value": "Val1"
                    },
                    {
                        "value": "Val2"
                    }
                ]
            },
            {
                "name": "Cat2",
                "values": [
                    {
                        "value": "Val1"
                    },
                    {
                        "value": "Val2"
                    },
                    {
                        "value": "Val3"
                    },
                    {
                        "value": "Val4"
                    }
                ]
            },
            {
                "name": "Cat3",
                "values": [
                    {
                        "value": "Val1"
                    },
                    {
                        "value": "Val2"
                    }
                ]
            }
        ],
        "date": "26.06.19",
        "meetingPoint": "A Gebäude",
        "name": "MOP",
        "password": null,
        "roomId": 800188,
        "time": "5:07 PM",
        "user": [
            {
                "name": "Klaus",
                "password": "",
                "userId": 126709
            }
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

  Future<User> joinRoom(int roomId, User participant) async {
    await Future.delayed(delay);
    return User.fromJson(json.decode(
      '''
        {
          "name": "Klaus",
          "password": "",
          "userId": 635869
        }
      '''
    ));
  }

  Future<List<Contribution>> fetchRoomContributions(Room room) async {
    await Future.delayed(delay);
    List responseJson = json.decode('[{"id": 0, "type": "contribution", "userId": 1337}, '
        '{"id": 1, "type": "question", "userId": 1337}]');
    return responseJson.map((m) => new Contribution.fromJson(m)).toList();
  }

  Future<Contribution> createRoomContribution(Room room, Contribution contribution, User user) async {
    await Future.delayed(delay);
    return Contribution.fromJson(json.decode(
        '''
        {
          "contribution":
          [
            {
              "art": "Frage",
              "contributionId": 456,
              "name": "user"
            }
          ]
        }
      '''
    ));
  }

  void removeRoomContribution(Room room, Contribution contribution, User user) async {

  }

  void setRoomContributionStartTime(Room room, Contribution contribution, User user, DateTime timeStart) async {

  }

  void setRoomContributionStopTime(Room room, Contribution contribution, User user, DateTime timeStop) async {

  }

  Future<List<EvaluatedContribution>> fetchRoomEvaluation(int roomId) async {
    List responseJson = json.decode(
      '''
        [
            {
                "_id": "5d2367307fca9b7175eb0596",
                "art": "lib/assets/rede_icon.png",
                "categories": [
                    {
                        "name": "cat",
                        "values": [
                            {
                                "value": "val"
                            }
                        ]
                    }
                ],
                "contributionId": 160732,
                "name": "Guenter",
                "roomId": 302483,
                "time": 5,
                "timeStart": "2019-07-08 17:55:49.641874",
                "timeStop": "2019-07-08 17:55:54.881814",
                "userId": 186600
            }
        ]
      '''
    );
    return responseJson.map((m) => EvaluatedContribution.fromJson(m)).toList();
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

  Future<User> joinRoom(int roomId, User participant) async {
    print(json.encode(participant));
    await Future.delayed(delay);
    throw Exception('Failed to join room. Error: ${404}');
  }

  Future<List<Contribution>> fetchRoomContributions(Room room) async {
    print(json.encode(room));
    await Future.delayed(delay);
    throw Exception('Failed to fetch room contributions. Error: ${404}');
  }

  Future<Contribution> createRoomContribution(Room room, Contribution contribution, User user) async {
    print(json.encode(room));
    await Future.delayed(delay);
    throw Exception('Failed to create room contribution. Error: ${404}');
  }

  void removeRoomContribution(Room room, Contribution contribution, User user) async {
    print(json.encode(room));
    await Future.delayed(delay);
    throw Exception('Failed to remove room contribution. Error: ${404}');
  }

  void setRoomContributionStartTime(Room room, Contribution contribution, User user, DateTime timeStart) async {
    print(json.encode(room));
    await Future.delayed(delay);
    throw Exception('Failed to set time. Error: ${404}');
  }

  void setRoomContributionStopTime(Room room, Contribution contribution, User user, DateTime timeStop) async {
    print(json.encode(room));
    await Future.delayed(delay);
    throw Exception('Failed to set time. Error: ${404}');
  }

  Future<List<EvaluatedContribution>> fetchRoomEvaluation(int roomId) async {
    await Future.delayed(delay);
    throw Exception('Failed to fetch room evaluation. Error: ${404}');
  }
}