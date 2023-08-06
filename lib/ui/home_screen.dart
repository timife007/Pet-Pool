import 'package:flutter/material.dart';
import 'package:pet_pool/data/pet_item.dart';
import 'package:pet_pool/data/pets_api.dart';
import 'package:http/http.dart' as http;
import 'package:pet_pool/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PetItem>> futureData;
  late String searchItem;

  @override
  void initState() {
    super.initState();
    searchItem = "";
    futureData = fetchPets(http.Client(), searchItem);
  }

  Future<void> _performSearch({String value = ''}) async {
    setState(() {
      futureData = fetchPets(http.Client(), searchItem);
      logger.d(searchItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home_filled),
        actions: const [Icon(Icons.notifications)],
        backgroundColor: Colors.green,
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
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('Search for pets')),
              textAlign: TextAlign.start,
              onChanged: (value) => {
                // setState(() {
                searchItem = value,
                // }),
                if (searchItem.isEmpty)
                  {_performSearch()}
                else
                  {_performSearch()}
              },
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                  onRefresh: _performSearch, child: buildFutureBuilder()))
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
        return Card(
            elevation: 4, // Controls the shadow intensity
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Adjust the corner radius here
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(pets[index].imageLink),
                ),
                Text(pets[index].name)
              ],
            ));
      },
    );
  }
}
