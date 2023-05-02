part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {
  final List<Chat> chats;

  const ChatLoadingState({required this.chats});

  @override
  List<Object> get props => chats.map((e) => e.content).toList();
}

class ChatLoadedState extends ChatState {
  final List<Chat> chats;

  const ChatLoadedState({required this.chats});

  @override
  List<Object> get props => chats.map((e) => e.content).toList();
}
