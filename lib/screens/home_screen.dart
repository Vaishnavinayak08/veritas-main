// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veritas/widgets/custom_buttons.dart';

import 'prompt_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'veritas',
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(image: AssetImage('assets/images/Welcome.png')),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                'Your feedback is valuable to us',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSerifDisplay(fontSize: 45),
              ),
            ),
            CustomButtons(
              text: 'Take Me',
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const PromptScreen(),
              )),
            ),
            const Center(child: Text('Terms and conditions apply')),
            const SizedBox(height: 10),
          ],
        ));
  }
}
