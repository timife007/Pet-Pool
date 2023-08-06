import 'package:flutter/material.dart';

import '../data/pet_item.dart';

class DetailScreen extends StatelessWidget {
  final PetItem petItem;
  const DetailScreen({super.key, required this.petItem});

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHeight = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        width: containerWidth,
                        height: containerHeight,
                        fit: BoxFit.cover,
                        petItem.imageLink,
                      ),
                    )),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_sharp),
                    ),
                  ),
                )
              ],
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              petItem.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ))
        ],
      ),
    );
  }
}
