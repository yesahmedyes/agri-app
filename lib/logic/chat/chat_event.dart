part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatNextEvent extends ChatEvent {
  final String question;

  const ChatNextEvent({required this.question});

  @override
  List<Object> get props => [question];
}
