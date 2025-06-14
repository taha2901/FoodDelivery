

import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/core/utilities/constants.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

abstract class FavouriteServices {
  Future<void> addFavourite(
      {required String userId, required FoodItemModel product});
  Future<void> removeFavourite({required String userId,required String productId});
  Future<List<FoodItemModel>> getFavourite({required String userId});
}

class FavouriteServicesImpl implements FavouriteServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<void> addFavourite(
      {required String userId, required FoodItemModel product}) async {
    await firestoreServices.setData(
      path: ApiPaths.favouriteProduct(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<void> removeFavourite({required String userId,required String productId}) async {
    await firestoreServices.deleteData(
        path: ApiPaths.favouriteProduct(userId, productId));
  }

  @override
  Future<List<FoodItemModel>> getFavourite({required String userId}) async {
    final res = await firestoreServices.getCollection(
      path: ApiPaths.favouriteProducts(userId),
      builder: (data, documentId) => FoodItemModel.fromMap(data, documentId),
    );
    return res;
  }
}
