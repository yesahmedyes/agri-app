part of 'suggestion_bloc.dart';

abstract class SuggestionEvent extends Equatable {
  const SuggestionEvent();

  @override
  List<Object> get props => [];
}

class SuggestionFetchEvent extends SuggestionEvent {
  final String productId;

  const SuggestionFetchEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
