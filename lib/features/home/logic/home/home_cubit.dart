import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/auth_services.dart';
import 'package:food_delivery/core/services/home_services.dart';
import 'package:food_delivery/features/home/data/models/category_item.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();
  // final favouriteServices = FavouriteServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchFoodItems();

      emit(HomeLoaded(
        products: products,
      ));
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

  // Future<void> setFavourite(ProductItemModel product, BuildContext context) async {
  //   emit(SetFavouriteLoading(productId: product.id));
  //   try {
  //     final currentUser = authServices.currentUser();
  //     final favouriteProducts = await favouriteServices.getFavourite(
  //       userId: currentUser!.uid,
  //     );
  //     // any  : بتلف على كل ايتيم موجود ف مفضلو ف هيبقا ب ترو
  //     final isFavourite =
  //         favouriteProducts.any((item) => item.id == product.id);
  //     if (isFavourite) {
  //       await favouriteServices.removeFavourite(
  //           userId: currentUser.uid, productId: product.id);
  //     } else {
  //       await favouriteServices.addFavourite(
  //           userId: currentUser.uid, product: product);
  //     }

  //     emit(SetFavouriteSuccess(isFav: !isFavourite, productId: product.id));

  //     BlocProvider.of<FavouriteCubit>(context).getFavoriteProducts();
  //   } catch (e) {
  //     emit(SetFavouriteFailure(e.toString(), product.id));
  //   }
  // }
}
