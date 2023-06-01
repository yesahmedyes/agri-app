import 'package:agriapp/data/models/product.dart';
import 'package:agriapp/data/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'suggestion_event.dart';
part 'suggestion_state.dart';

class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionState> {
  final ProductsRepository _productsRepository;

  SuggestionBloc({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(SuggestionInitialState()) {
    on<SuggestionFetchEvent>((event, emit) async {
      emit(SuggestionInitialState());

      final Product? product = await _productsRepository.fetchSuggestion(event.productId);

      if (product != null) {
        emit(SuggestionFetchedState(product: product));
      }
    });
  }
}
