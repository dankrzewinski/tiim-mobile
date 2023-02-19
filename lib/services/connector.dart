import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/Car.dart';
import '../model/CarDetails.dart';

Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'Accept': 'application/json'
};
// Create storage
const storage = FlutterSecureStorage();

const String baseUrl = "http://192.168.0.124";
const String baseUrlWithPort = "http://192.168.0.124:8080";
const String localHost = "http://127.0.0.1";

Future<void> register(String username, String name, String surname, String email,
    String password) async {
  final response = await http.post(
    Uri.parse('$baseUrlWithPort/api/users/registration'),
    headers: requestHeaders,
    body: json.encode({
      'username': username,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password
    }),
  );

  if (!response.ok) {
    throw Exception("error");
  }

}

Future<String?> login(String login, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrlWithPort/api/authentication'),
    headers: requestHeaders,
    body: json.encode({
      'userName': login,
      'password': password,
    }),
  );

  if (response.ok) {
    String token = jsonDecode(response.body)['token'];
    await storage.write(key: "token", value: token);
    return await storage.read(key: "token");
  }

  throw Exception("error");
}

Future<List<Car>> getCars() async {
  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  final response = await http.get(
    Uri.parse('$baseUrlWithPort/api/car'),
    headers: Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}),
  );

  if (response.ok) {
    final jsonBody = jsonDecode(response.body);
    return (jsonBody['items'] as List).map((e) => Car.fromJson(e)).toList();
  }

  storage.delete(key: "token");
  throw Exception("exception");
}

Future<CarDetails> getCarDetails(String carId) async {
  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  final response = await http.get(
    Uri.parse('$baseUrlWithPort/api/car/$carId'),
    headers: Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}),
  );

  if (response.ok) {
    final jsonBody = jsonDecode(response.body);
    return CarDetails.fromJson(jsonBody);
  }

  storage.delete(key: "token");
  throw Exception("exception");
}

Future<void> deleteCar(String carId) async {
  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  final response = await http.delete(
    Uri.parse('$baseUrlWithPort/api/car/$carId'),
    headers: Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}),
  );

  if (!response.ok) {
    storage.delete(key: "token");
    throw Exception("exception");
  }

}

Future<bool> handleFavoriteButton(bool isLiked, String carId) async {
  if(isLiked) {
    return dislike(carId);
  } else {
    return like(carId);
  }
}

Future<bool> dislike(String carId) async {
  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  final response = await http.post(
    Uri.parse('$baseUrlWithPort/api/car/$carId/dislike'),
    headers: Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}),
  );

  if (response.ok) {
    return false;
  }

  storage.delete(key: "token");
  throw Exception("exception");
}

Future<bool> like(String carId) async {
  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  final response = await http.post(
    Uri.parse('$baseUrlWithPort/api/car/$carId/like'),
    headers: Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}),
  );

  if (response.ok) {
    return true;
  }

  storage.delete(key: "token");
  throw Exception("exception");
}

Future<void> addCar(String make, String model, String color, String engineSize,
    String horsePower, String filePath) async {

  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  File file = File.fromUri(Uri.parse(filePath));
  List<int> fileBytes = await file.readAsBytes();
  int fileLength = file.lengthSync();

  final request = http.MultipartRequest(
    "POST",
    Uri.parse('$baseUrlWithPort/api/car'))
    ..headers.addAll(Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}))
    ..files.add(await http.MultipartFile.fromPath('file', filePath))
    ..fields.addAll({
      'make':make,
      'model':model,
      'color':color,
      'engineSize': engineSize,
      'horsePower': horsePower
    });

  final response = await request.send();


  if (response.ok) {
    return;
  }

  storage.delete(key: "token");
  throw Exception("exception");
}

Future<void> updateCar(String carId, String make, String model, String color, String engineSize,
    String horsePower) async {

  String? token = await storage.read(key: "token");

  if (token == null) {
    throw Exception("no token");
  }

  final request = http.MultipartRequest(
      "PUT",
      Uri.parse('$baseUrlWithPort/api/car/$carId'))
    ..headers.addAll(Map<String, String>.from(requestHeaders)
      ..addAll({'Authorization': 'Bearer $token'}))
    ..fields.addAll({
      'make':make,
      'model':model,
      'color':color,
      'engineSize': engineSize,
      'horsePower': horsePower
    });

  final response = await request.send();

  print(response.statusCode);

  if (response.ok) {
    return;
  }

  storage.delete(key: "token");
  throw Exception("exception");
}

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

extension IsOkStreamed on http.StreamedResponse {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}
