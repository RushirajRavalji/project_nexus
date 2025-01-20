import 'package:flutter/material.dart';
import 'package:project_nexus/main.screen.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Center the image
          Center(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white, // Replace with your desired color
                BlendMode.modulate, // Change blend mode if needed
              ),
              child: Image(
                image: AssetImage('assets/images/nexus_logo.png'),
              ),
            ),
          ),
          // Align the button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0), // Add padding to the bottom
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                ),
                child: Container(
                  width: 250.0, // Button width
                  height:
                      50.0, // Button height (set to 50px for a typical button height)
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Transparent background
                    border: Border.all(
                      color: Colors.grey.shade800, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius:
                        BorderRadius.circular(18.0), // Rounded corners
                  ),
                  alignment: Alignment.center, // Center the text
                  child: Text(
                    "Let's Go -->",
                    style: TextStyle(
                      color: Colors.grey, // Text color
                      fontSize: 16.0, // Text size
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
