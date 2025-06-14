
import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/core/utilities/constants.dart';
import 'package:food_delivery/features/cart/data/add_to_cart.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

abstract class ProductDetailsServices {
  Future<FoodItemModel> fetchProductDetails(String productId);

  Future<void> addToCart(AddToCartModel cartItem, String userId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestoreServices = FirestoreServices.instance;
  @override
  Future<FoodItemModel> fetchProductDetails(String productId) async {
    final selectedProduct =
        await firestoreServices.getDocument<FoodItemModel>(
      path: ApiPaths.product(productId),
      builder: (data, documentId) => FoodItemModel.fromMap(data, documentId),
    );
    return selectedProduct;
  }

  @override
  Future<void> addToCart(AddToCartModel cartItem, String userId) async {
    await firestoreServices.setData(
      path: ApiPaths.cartItem(userId, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
