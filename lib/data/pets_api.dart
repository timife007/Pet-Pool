import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pet_pool/data/pet_item.dart';
import 'package:pet_pool/logger.dart';

List<PetItem> parsePets(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  logger.d(responseBody);
  var petlist = parsed.map<PetItem>((json) => PetItem.fromJson(json)).toList();
  return petlist;
}

Future<List<PetItem>> fetchPets(http.Client client, String name) async {
  final response = await client.get(
      Uri.parse('https://api.api-ninjas.com/v1/dogs?name=$name'),
      headers: {'X-Api-Key': 'CYFtX0dCmZVgtXJnItZ91A==Sn02Qls8KW0Lpkxi'});
  // logger.d(response.body);
  return compute(parsePets, response.body);
}
