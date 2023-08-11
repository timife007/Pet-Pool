import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_pool/data/pets_api.dart';
import 'pet_list.dart';

class PetListScreen extends ConsumerStatefulWidget {
  const PetListScreen({super.key});

  @override
  PetListScreenState createState() => PetListScreenState();
}

class PetListScreenState extends ConsumerState<PetListScreen> {
  // late Future futureData;

  @override
  void initState() {
    super.initState();
    // ref.watch(petsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final pets = ref.watch(petsProvider);
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
              onChanged: (value) =>
                  {ref.read(searchProvider.notifier).state = value},
            ),
          ),
          Container(
            child: pets.when(
                data: (messages) {
                  if (messages.isEmpty) {
                    return const Center(child: Text('Error fetching data'));
                  }
                  return Expanded(child: PetList(pets: messages));
                },
                error: ((error, stackTrace) =>
                    const Expanded(child: Text('Error fetching data'))),
                loading: () => const CircularProgressIndicator.adaptive()),
          ),

          // Expanded(
          //     child: RefreshIndicator(
          //         onRefresh: ,
          //         child: buildStreamBuilder()))
        ],
      ),
    );
  }
}
