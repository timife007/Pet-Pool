import 'package:flutter/material.dart';
import 'package:pet_pool/data/pet_item.dart';
import 'package:pet_pool/data/pets_api.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<PetItem>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchPets(http.Client(), '');
  }

  void _performSearch() {
    setState(() {
      futureData = fetchPets(http.Client(), _searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Pet Pool',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Search for pets')),
              textAlign: TextAlign.start,
              onChanged: (value) => _performSearch(),
            ),
          ),
          Expanded(child: buildFutureBuilder())
        ],
      ),
    );
  }

  FutureBuilder<List<PetItem>?> buildFutureBuilder() {
    // Future<List<PetItem> future = fetchPets(http.Client(), '');

    return FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            return PetList(pets: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
