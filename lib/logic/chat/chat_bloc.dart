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
      emit(ChatLoadedState(chats: chats));

      await Future.delayed(const Duration(seconds: 2));
      chats.add(
        Chat(
          role: 'assistant',
          content:
              "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        ),
      );
      // await chatRepository.requestChat(chat);

      emit(ChatInitialState());
      emit(ChatLoadedState(chats: chats));
    });
  }
}
