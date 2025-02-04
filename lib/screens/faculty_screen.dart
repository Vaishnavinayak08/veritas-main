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
import '../widgets/custom_buttons.dart'; // Import your CustomButtons widget

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
          'Faculty Feedback',
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
                      CustomButtons(
                        text: 'Cancel',
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CustomButtons(
                        text: 'Delete',
                        onTap: () async {
                          Box box = await context
                              .read<HiveRepository>()
                              .openFacultytBox();
                          context
                              .read<MessagesBloc>()
                              .add(MesagesDeleteEvent(box: box));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessagesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessagesLoadedState) {
                  List<MessageModel> message = state.message;
                  if (message.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: message.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  message[index].message,
                                  style: GoogleFonts.inter(fontSize: 16),
                                  textAlign: TextAlign.end,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  message[index].date,
                                  style: GoogleFonts.inter(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/vcetlogo.jpg'),
                            height: 200,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Nothing to see here. Let us know what you think!',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
            prompt: 'Tell us what you think...',
            onSubmitted: () async {
              if (messageController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Message cannot be empty'),
                ));
                return;
              }

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
                content: Text('Your feedback has been successfully sent'),
              ));
            },
            controller: messageController,
          ),
        ],
      ),
    );
  }
}
