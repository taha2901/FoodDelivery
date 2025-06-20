part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final FoodItemModel product;
  ProductDetailsLoaded({required this.product});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}

final class QuantityCounterLoaded extends ProductDetailsState {
  final int value;
  QuantityCounterLoaded({required this.value});
}

// final class SizeSelected extends ProductDetailsState {
//   final ProductSize size;
//   SizeSelected({required this.size});
// }

// final class ProductAddedToCart extends ProductDetailsState {
//   final String productId;
//   ProductAddedToCart({required this.productId});
// }

// final class ProductAddingToCart extends ProductDetailsState {}

// final class ProductAddedToCartError extends ProductDetailsState {
//   final String message;
//   ProductAddedToCartError({required this.message});
// }
