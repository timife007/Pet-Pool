import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pet_pool/data/pet_item.dart';

class Model {
  final StreamController _streamController = StreamController();

  Stream get modelState => _streamController.stream;

  List<PetItem> parsePets(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    // logger.d(responseBody);
    var petlist =
        parsed.map<PetItem>((json) => PetItem.fromJson(json)).toList();
    return petlist;
  }

// ignore: body_might_complete_normally_nullable
  fetchPets(http.Client client, String name) async {
    try {
      final response = await client.get(
          Uri.parse('https://api.api-ninjas.com/v1/dogs?name=$name'),
          headers: {'X-Api-Key': 'CYFtX0dCmZVgtXJnItZ91A==Sn02Qls8KW0Lpkxi'});
      // logger.d(response.body);
      final parsedData = parsePets(response.body); // Parse data here
      _streamController.add(parsedData);
    } catch (e) {
      _streamController.addError('Error fetchind data');
    }
  }
}
