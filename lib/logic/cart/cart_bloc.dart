import 'dart:async';

import 'package:agriapp/data/models/cart.dart';
import 'package:agriapp/data/models/cartItem.dart';
import 'package:agriapp/data/repositories/cart_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  StreamSubscription? subscription;

  CartBloc({required CartRepository cartRepository})
      : _cartRepository = cartRepository,
        super(CartInitialState()) {
    on<CartCheckStatusEvent>(_onCheckStatus);
    on<CartUpdateEvent>(_onUpdate);
    on<CartUpdateCompleteEvent>(_onUpdateComplete);
  }

  _onCheckStatus(CartCheckStatusEvent event, Emitter<CartState> emit) async {
    final Cart cart = await _cartRepository.fetchCart();

    emit(CartOpenedState(items: cart.items));
  }

  _onUpdate(CartUpdateEvent event, Emitter<CartState> emit) async {
    subscription ??= _cartRepository.stream.listen((cart) {
      add(CartUpdateCompleteEvent(items: cart.items, message: cart.message));
    });

    final Map<String, dynamic> _data = {
      'categoryId': event.categoryId,
      'productId': event.productId,
      'productName': event.productName,
      'productImage': event.productImage,
      'quantity': event.quantity,
      'price': event.price,
    };

    _cartRepository.updateCart(data: _data);
  }

  _onUpdateComplete(CartUpdateCompleteEvent event, Emitter<CartState> emit) {
    emit(CartOpenedState(items: event.items));
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
