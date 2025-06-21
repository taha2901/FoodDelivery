

import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/core/utilities/constants.dart';
import 'package:food_delivery/features/home/data/models/category_item.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

abstract class HomeServices {
  Future<List<FoodItemModel>> fetchFoodItems();
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

}
