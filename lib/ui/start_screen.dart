import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/unsplash.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        'Happiness is closer than you think', // Replace with your desired text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16.0),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 223, 120, 112),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      child: const Text(
                        "Let's Go!",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
