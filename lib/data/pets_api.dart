import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pet_pool/data/pet_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'pets_api.g.dart';

class Model {
  List<PetItem> parsePets(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    var petlist =
        parsed.map<PetItem>((json) => PetItem.fromJson(json)).toList();
    return petlist;
  }
}

/// Provider for the search item string
final searchProvider = StateProvider<String>((ref) => "");

// Stream of data provider
@riverpod
Stream<List<PetItem>> pets(PetsRef ref) async* {
  final searchItem = ref.watch(searchProvider);
  final model = Model();

  try {
    final response = await http.Client().get(
        Uri.parse('https://api.api-ninjas.com/v1/dogs?name=$searchItem'),
        headers: {'X-Api-Key': 'CYFtX0dCmZVgtXJnItZ91A==Sn02Qls8KW0Lpkxi'});
    final parsedData = model.parsePets(response.body); // Parse data here
    yield parsedData;
  } catch (e) {
    yield [];
  }
}