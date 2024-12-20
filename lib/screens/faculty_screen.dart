// screens/faculty_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../bloc/messages_bloc.dart';
import '../model/message_model.dart';
import '../repository/hive_repository.dart';
import '../widgets/message_field.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMMMEd().format(DateTime.now()).toString();
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Faculty',
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text(
                        'This will delete all messages. Are you sure?',
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Box box = await context
                                .read<HiveRepository>()
                                .openFacultytBox();
                            context
                                .read<MessagesBloc>()
                                .add(MesagesDeleteEvent(box: box));
                            Navigator.of(context)
                                .pop(); // Close the dialog after deletion
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete_rounded,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is MessagesLoadedState) {
                  List<MessageModel> message = state.message;
                  if (message.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: message.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 20.0, left: 20, bottom: 8, top: 8),
                          child: Text(
                            message[index].message,
                            style: GoogleFonts.inter(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        );
                      },
                    );
                  } else {
                    return const SingleChildScrollView(
                      child: Column(
                        children: [
                          Image(
                              image: AssetImage(
                                  'assets/images/No_list_found.png')),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20),
                            child: Text(
                              'Nothing to see here. Let us know what you think!',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Something Went Wrong'),
                  );
                }
              },
            ),
          ),
          MessageField(
            prompt: 'Tell us what you think.',
            onSubmitted: () async {
              Box box = await context.read<HiveRepository>().openFacultytBox();
              context.read<MessagesBloc>().add(MessagesAddEvent(
                  createdAt: date,
                  tableName: 'Faculty',
                  box: box,
                  message: MessageModel(
                      message: messageController.text, date: date)));
              context.read<MessagesBloc>().add(MessagesLoadEvent(box: box));
              messageController.clear();

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Durations.long4,
                  content: Text('Your feedback has been successfully sent')));
            },
            controller: messageController,
          )
        ],
      ),
    );
  }
}


