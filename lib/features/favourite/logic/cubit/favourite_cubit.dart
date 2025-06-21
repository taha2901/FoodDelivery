
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/auth_services.dart';
import 'package:food_delivery/core/services/favourite_services.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

part 'favourite_state.dart';


class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final favoriteServices = FavouriteServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getFavoriteProducts() async {
    emit(FavouriteLoading());
    try {
      final currentUser = authServices.currentUser();
      final favoriteProducts = await favoriteServices.getFavourite(
        userId: currentUser!.uid,
      );
      emit(FavouriteLoaded(favouriteProduct: favoriteProducts));
    } catch (e) {
      emit(FavouriteError(errorMessage: e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    emit(FavouriteRemoveing(productId: productId));
    try {
      final currentUser = authServices.currentUser();
      await favoriteServices.removeFavourite(
        userId: currentUser!.uid,
        productId: productId,
      );
      emit(FavouriteRemoved(productId: productId));
      final favoriteProducts = await favoriteServices.getFavourite(
        userId: currentUser.uid,
      );
      emit(FavouriteLoaded(favouriteProduct: favoriteProducts));
    } catch (e) {
      emit(FavouriteRemoveError(errMessage: e.toString()));
    }
  }
}
