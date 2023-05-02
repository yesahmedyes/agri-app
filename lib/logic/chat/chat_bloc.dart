import 'package:agriapp/data/models/chat.dart';
import 'package:agriapp/data/repositories/chat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  final List<Chat> chats = [];

  ChatBloc({required this.chatRepository}) : super(ChatInitialState()) {
    on<ChatNextEvent>((event, emit) async {
      final chat = Chat(role: 'user', content: event.question);

      chats.add(chat);

      emit(ChatInitialState());
      emit(ChatLoadingState(chats: chats));

      final Chat? responseChat = await chatRepository.requestChat(chat);

      if (responseChat != null) {
        chats.add(responseChat);
      }

      emit(ChatLoadedState(chats: chats));
    });
  }
}
