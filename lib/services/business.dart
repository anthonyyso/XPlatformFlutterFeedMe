import 'package:feedme/services/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class Business {
  final String id;
  final String name;
  final String imageUrl;

  Business({this.id, this.name, this.imageUrl});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

Future<List<Business>> fetchBusinessList() async {
  await DotEnv().load('.env');
  Location location = Location();
  await location.getLocation();
  print("Location: ${location.latitude} :  ${location.longitude}");
  var response = await http.get(
    'https://api.yelp.com/v3/businesses/search' +
        "?&latitude=${location.latitude}&longitude=${location.longitude}",
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${DotEnv().env['API_KEY']}"
    },
  );
  print(response.body);
  // get the businesses from the response
  Iterable decodedData = jsonDecode(response.body)['businesses'];

  List<Business> businesses = decodedData
      .map((businessJson) => Business.fromJson(businessJson))
      .toList();

  return businesses;
}
