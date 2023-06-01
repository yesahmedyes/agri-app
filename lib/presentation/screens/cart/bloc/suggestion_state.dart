part of 'suggestion_bloc.dart';

abstract class SuggestionState extends Equatable {
  const SuggestionState();

  @override
  List<Object> get props => [];
}

class SuggestionInitialState extends SuggestionState {}

class SuggestionFetchedState extends SuggestionState {
  final Product product;

  const SuggestionFetchedState({required this.product});

  @override
  List<Object> get props => [product];
}
