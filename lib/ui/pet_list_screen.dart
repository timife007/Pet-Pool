import 'package:flutter/material.dart';
import 'package:pet_pool/data/pet_item.dart';
import 'package:pet_pool/data/pets_api.dart';
import 'package:http/http.dart' as http;
import 'package:pet_pool/logger.dart';
import 'package:pet_pool/ui/detail_screen.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  late Future futureData;
  late String searchItem;
  final model = Model();

  @override
  void initState() {
    super.initState();
    searchItem = "";
    futureData = model.fetchPets(http.Client(), searchItem);
  }

  Future<void> _performSearch({String value = ''}) async {
    setState(() {
      futureData = model.fetchPets(http.Client(), searchItem);
      logger.d(searchItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.person_2_rounded)),
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
                  labelStyle:
                      TextStyle(color: Colors.black), // Color of the label text

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.green), // Border color when focused
                  ),
                  border: OutlineInputBorder(),
                  label: Text('Search for pets')),
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
                  onRefresh: _performSearch, child: buildStreamBuilder()))
        ],
      ),
    );
  }

  StreamBuilder buildStreamBuilder() {
    return StreamBuilder(
        stream: model.modelState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
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
          }
          return Text(snapshot.error.toString());
        });
  }
}

class PetList extends StatelessWidget {
  const PetList({super.key, required this.pets});

  final List<PetItem> pets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(petItem: pets[index])));
            },
            child: Card(
                elevation: 4, // Controls the shadow intensity
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the corner radius here
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(pets[index].imageLink),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pets[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
