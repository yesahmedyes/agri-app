part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitialState extends OrdersState {}

class OrdersFetchingState extends OrdersState {}

class OrdersSuccessState extends OrdersState {
  final List<MyOrder> orders;

  const OrdersSuccessState(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrdersFailedState extends OrdersState {
  final String error;

  const OrdersFailedState({required this.error});

  @override
  List<Object> get props => [error];
}
