part of 'messages_bloc.dart';

class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class MessagesAddEvent extends MessagesEvent {
  final Box box;
  final MessageModel message;
  final String tableName;
  final String createdAt;

  const MessagesAddEvent(
      {required this.box,
      required this.message,
      required this.tableName,
      required this.createdAt});

  @override
  List<Object> get props => [box, message];
}

class MessagesLoadEvent extends MessagesEvent {
  final Box box;

  const MessagesLoadEvent({required this.box});

  @override
  List<Object> get props => [box];
}

class MesagesDeleteEvent extends MessagesEvent {
  final Box box;

  const MesagesDeleteEvent({required this.box});

  @override
  List<Object> get props => [box];
}
