// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veritas/widgets/custom_buttons.dart';

import 'prompt_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for dynamic padding
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confesso',
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding based on screen width
            child: const Image(image: AssetImage('assets/images/vcetlogo.jpg')),
          ),
          const Spacer(), // Ensures "Your feedback is valuable to us" is in the same position
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Text(
              'Your feedback is valuable to us',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSerifDisplay(fontSize: 38),
            ),
          ),
          CustomButtons(
            text: 'Take Me',
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const PromptScreen(),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Terms and conditions apply',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const Spacer(),
         Container(
  width: double.infinity,
  color: Colors.black,
  padding: const EdgeInsets.all(10),
  margin: const EdgeInsets.only(bottom: 10), // Add margin to create space above the bottom edge
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Developed by Vaishali, Vaishali K S, Vaishnavi',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 10),
    ],
  ),
),

          
        ], // This is where the list ends; remove the semicolon!
      ),
    );
  }
}
