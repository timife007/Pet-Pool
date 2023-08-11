import 'package:flutter/material.dart';
import '../data/pet_item.dart';
import 'detail_screen.dart';

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
