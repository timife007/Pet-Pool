import 'package:flutter/material.dart';
import 'package:pet_pool/data/pet_item.dart';
import 'package:pet_pool/data/pets_api.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchPets(http.Client(), 'Australian'),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return PetList(pets: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class PetList extends StatelessWidget {
  const PetList({super.key, required this.pets});

  final List<PetItem> pets;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return Image.network(pets[index].imageLink);
      },
    );
  }
}
