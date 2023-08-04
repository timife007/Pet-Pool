import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pet_pool/data/pet_item.dart';

List<PetItem> parsePets(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<PetItem>((json) => PetItem.fromJson(parsed)).toList();
}

Future<List<PetItem>> fetchPets(http.Client client, String name) async {
  final response = await client.get(
      Uri.parse('https://api.api-ninjas.com/v1/dogs/name=$name'),
      headers: {'X-Api-Key': 'CYFtX0dCmZVgtXJnItZ91A==Sn02Qls8KW0Lpkxi'});
  return compute(parsePets, response.body);
}
