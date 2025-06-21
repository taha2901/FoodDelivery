part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<FoodItemModel> products;
  HomeLoaded({
    required this.products,
  });
}

final class HomeError extends HomeState {
  final String errMessage;

  HomeError(this.errMessage);
}

final class CategoryLoading extends HomeState {}

final class CategoryLoaded extends HomeState {
  final List<CategoryItemModel> categories; 
  CategoryLoaded({
    required this.categories,
  });
}

final class CategoryError extends HomeState {
  final String errMessage;

  CategoryError(this.errMessage);
}

final class SetFavouriteLoading extends HomeState {
  final String productId;

  SetFavouriteLoading({required this.productId});
}

final class SetFavouriteSuccess extends HomeState {
  final bool isFav;
  final String productId;

  SetFavouriteSuccess( {required this.isFav, required this.productId});
}

final class SetFavouriteFailure extends HomeState {
  final String errMessage;
  final String productId;
  SetFavouriteFailure(this.errMessage, this.productId);
}
