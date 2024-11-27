// screens/prompt_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:veritas/bloc/messages_bloc.dart';
import 'package:veritas/repository/hive_repository.dart';
import '../widgets/custom_buttons.dart';
import 'faculty_screen.dart';
import 'student_screen.dart';
import 'password_screen.dart';

class PromptScreen extends StatelessWidget {
  const PromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'veritas',
        style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8),
              child: SizedBox(
                  child: Image(
                      image: AssetImage('assets/images/Page_not_found.png'))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                'We dont value your opinion',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSerifDisplay(fontSize: 45),
              ),
            ),
            const SizedBox(height: 50),
            CustomButtons(
  text: 'For faculties',
  onTap: () async {
    Box box = await context.read<HiveRepository>().openFacultytBox();
    context.read<MessagesBloc>().add(MessagesLoadEvent(box: box));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PasswordScreen(
        correctPassword: 'faculty123', // Replace with your desired password
        nextScreen: const FacultyScreen(),
      ),
    ));
  },
),
CustomButtons(
  text: 'For students',
  onTap: () async {
    Box box = await context.read<HiveRepository>().openStudentBox();
    context.read<MessagesBloc>().add(MessagesLoadEvent(box: box));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PasswordScreen(
        correctPassword: 'student123', // Replace with your desired password
        nextScreen: const StudentScreen(),
      ),
    ));
  },
),
          ],
        ),
      ),
    );
  }
}
