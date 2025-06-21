import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/auth_services.dart';
import 'package:food_delivery/core/services/favourite_services.dart';
import 'package:food_delivery/core/services/home_services.dart';
import 'package:food_delivery/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:food_delivery/features/home/data/models/category_item.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

part 'home_state.dart';
// 4 steps to filter products from categories
// 3 steps here  and one in home page in build category list
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();
  List<FoodItemModel> allProducts = [];  // 1 - filter

  final favouriteServices = FavouriteServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchFoodItems();
      allProducts = products; // 2 - filter
      emit(HomeLoaded(products: products));
    } catch (e) {
      emit(HomeError("Error: $e"));
    }
  }

  void getCategoryData() async {
    emit(CategoryLoading());
    try {
      final categories = await homeServices.fetchCategories();
      emit(CategoryLoaded(
        categories: categories,
      ));
    } catch (e) {
      emit(CategoryError("Error: $e"));
    }
  }


  // 3 - filter
  void filterProductsByCategory(String categoryId) {
    final filtered =
        allProducts.where((item) => item.categoryId == categoryId).toList();
    emit(HomeLoaded(products: filtered));
  }

 Future<void> setFavourite(FoodItemModel product, BuildContext context) async {
  final oldStatus = product.isFavorite;
  product.isFavorite = !oldStatus;
  emit(HomeLoaded(products: List.from(allProducts))); // Update UI first (optimistic update)
  emit(SetFavouriteSuccess(isFav: !oldStatus, productId: product.id)); // Optimistic

  try {
    final currentUser = authServices.currentUser();
    if (oldStatus) {
      await favouriteServices.removeFavourite(
        userId: currentUser!.uid,
        productId: product.id,
      );
    } else {
      await favouriteServices.addFavourite(
        userId: currentUser!.uid,
        product: product,
      );
    }

    // Actual sync complete (optional emit)
  } catch (e) {
    product.isFavorite = oldStatus; // Rollback on error
    emit(SetFavouriteFailure(e.toString(), product.id));
  }
}

}
