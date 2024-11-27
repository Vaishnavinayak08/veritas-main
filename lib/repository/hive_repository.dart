import 'package:hive_flutter/hive_flutter.dart';

import '../model/message_model.dart';

class HiveRepository {
  //notes box opening
  Future<Box> openStudentBox() async {
    Box studentBox = await Hive.openBox<MessageModel>('student');
    return studentBox;
  }

  //faculty box opening
  Future<Box> openFacultytBox() async {
    Box facultyBox = await Hive.openBox<MessageModel>('faculty');
    return facultyBox;
  }

  //Get messages from the specific box student and the faculty
  List<MessageModel> getMesages(Box box) {
    return box.values.toList().cast<MessageModel>();
  }

  //add a message to the local storage
  Future<void> createMessage(Box box, MessageModel message) async {
    await box.add(message);
  }

  //Delete single messages
  Future<void> deleteMessage(Box box, int index) async {
    await box.deleteAt(index);
  }

  //delete all the data stored in the box
  Future<void> deleteAllMessages(Box box) async {
    await box.deleteAll(box.keys);
  }
}
