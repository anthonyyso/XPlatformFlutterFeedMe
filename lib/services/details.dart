import 'dart:convert';
import 'dart:io';
import 'package:feedme/services/businessLocation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Details {
  final String name;
  final List<String> photos;
  final BusinessLocation address;

  Details({this.name, this.photos, this.address});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      name: json['name'],
      photos: (json['photos'] as List).cast<String>(),
      address: BusinessLocation.fromJson(json['location']),
    );
  }
}

Future<Details> fetchBusinessDetails(String id) async {
  await DotEnv().load('.env');
  var response = await http.get(
    'https://api.yelp.com/v3/businesses/$id',
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${DotEnv().env['API_KEY']}"
    },
  );
  Details decodedData = Details.fromJson(jsonDecode(response.body));
  return decodedData;
}
