

import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/core/utilities/constants.dart';
import 'package:food_delivery/features/home/data/models/category_item.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

abstract class HomeServices {
  Future<List<FoodItemModel>> fetchFoodItems();
  // Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems();
  Future<List<CategoryItemModel>> fetchCategories();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<List<FoodItemModel>> fetchFoodItems() async {
    final resultOfProducts = await firestoreServices.getCollection<FoodItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => FoodItemModel.fromMap(data, documentId),
    );
    return resultOfProducts;
  }

  @override
  Future<List<CategoryItemModel>> fetchCategories() async {
    final resultOfCategory =
        await firestoreServices.getCollection<CategoryItemModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryItemModel.fromMap(data),
    );
    return resultOfCategory;
  }

  // @override
  // Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems() async {
  //   final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
  //     path: ApiPaths.announcments(),
  //     builder: (data, documentId) => HomeCarouselItemModel.fromMap(data),
  //   );
  //   return result;
  // }

  // @override
  // Future<void> addFavouriteProduct(
  //     {required String userId, required ProductItemModel product}) async {
  //   await firestoreServices.setData(
  //     path: ApiPaths.favouriteProduct(userId, product.id),
  //     data: product.toMap(),
  //   );
  // }

  // @override
  // Future<void> removeFavouriteProduct(
  //     {required String userId, required String productId}) async {
  //   await firestoreServices.deleteData(
  //       path: ApiPaths.favouriteProduct(userId, productId));
  // }

  // @override
  // Future<List<ProductItemModel>> fetchFavouriteProducts({ required String userId}) async {
  //   final result = await firestoreServices.getCollection<ProductItemModel>(
  //     path: ApiPaths.favouriteProducts(userId),
  //     builder: (data, documentId) => ProductItemModel.fromMap(data, documentId),
  //   );
  //   return result;
  // }
}
