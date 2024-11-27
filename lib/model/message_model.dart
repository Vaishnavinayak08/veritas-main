// model/message_model.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 1)
class MessageModel {
  @HiveField(0)
  final String message;
  @HiveField(1)
  final String date;
  @HiveField(2)
  MessageModel({required this.message, required this.date});

  MessageModel copyWith({
    String? message,
    String? date,
  }) {
    return MessageModel(
      message: message ?? this.message,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'date': date,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MessageModel(message: $message, date: $date)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.message == message && other.date == date;
  }

  @override
  int get hashCode => message.hashCode ^ date.hashCode;
}
