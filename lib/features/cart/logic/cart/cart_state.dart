part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}



final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;

  const CartLoaded(this.cartItems, this.subtotal);
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);
}

final class QuantityCounterLoaded extends CartState {
  final int value;
  final String productId;

  const QuantityCounterLoaded({required this.value, required this.productId,});
}

final class QuantityCounterError extends CartState {
  final String message;

  const QuantityCounterError(this.message);
}

final class QuantityCounterLoading extends CartState {}

final class SubtotalUpdated extends CartState {
  final double subtotal;

  const SubtotalUpdated(this.subtotal);
}

final class ProductAddedToCart extends CartState {
  final String productId;
  ProductAddedToCart({required this.productId});
}

final class ProductAddingToCart extends CartState {}

final class ProductAddedToCartError extends CartState {
  final String message;
  ProductAddedToCartError({required this.message});
}