// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:veritas/repository/supabase_repository.dart';

import '../model/message_model.dart';
import '../repository/hive_repository.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final HiveRepository _hiveRepository;
  final SupabaseRepository _supabaseRepository;
  MessagesBloc(this._hiveRepository, this._supabaseRepository)
      : super(MessagesLoadingState()) {
    on<MessagesLoadEvent>((event, emit) async {
      emit(MessagesLoadingState());
      List<MessageModel> messages = _hiveRepository.getMesages(event.box);
      emit(MessagesLoadedState(message: messages));
    });

    on<MessagesAddEvent>(
      (event, emit) async {
        emit(MessagesLoadingState());
        try {
          _supabaseRepository.addMessages(
              tableName: event.tableName,
              message: event.message.message,
              createdAt: event.createdAt);
          await _hiveRepository.createMessage(event.box, event.message);
          List<MessageModel> messages = _hiveRepository.getMesages(event.box);
          emit(MessagesLoadedState(message: messages));
        } catch (e) {
          emit(MessagesErrorState(errorMessage: e.toString()));
        }
      },
    );

    on<MesagesDeleteEvent>(
      (event, emit) async {
        emit(MessagesLoadingState());
        await _hiveRepository.deleteAllMessages(event.box);
        List<MessageModel> messages = _hiveRepository.getMesages(event.box);
        emit(MessagesLoadedState(message: messages));
      },
    );
  }
}
