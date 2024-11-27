part of 'messages_bloc.dart';

class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesLoadingState extends MessagesState {}

class MessagesLoadedState extends MessagesState {
  final List<MessageModel> message;

  const MessagesLoadedState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesErrorState extends MessagesState {
  final String errorMessage;

  const MessagesErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
