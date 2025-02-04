// screens/password_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veritas/widgets/password_field.dart';

import '../widgets/custom_buttons.dart';

class PasswordScreen extends StatelessWidget {
  final String correctPassword;
  final Widget nextScreen;

  const PasswordScreen({
    Key? key,
    required this.correctPassword,
    required this.nextScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
            title: Text(
          'Confesso',
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
        )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
             
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/vcetlogo.jpg')),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSerifDisplay(fontSize: 45),
                ),
              ),
            
          PasswordField(controller: passwordController, onSubmitted: null, prompt: 'Enter your password',icon: Icons.lock_rounded,borderRadius: 15,),
              
              const SizedBox(height: 20),
       
          CustomButtons(
            padding: 10,
            onTap: () {
               
              if (passwordController.text == correctPassword) {
                Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => nextScreen),
                );
              } else {
                showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Incorrect Password'),
            content: const Text('Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
                );
              }
            
          },text: 'Login',)
            ],
          ),
        ),
      ),
    );
  }
}
