import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/core/utilities/constants.dart';
import 'package:food_delivery/features/cart/data/add_to_cart.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItems(String userId);
  Future<void> setCartItem(String userId, AddToCartModel cartItem);
}

class CartServicesImp implements CartServices {
  final fireStoreServices = FirestoreServices.instance;
  @override
  Future<List<AddToCartModel>> fetchCartItems(String userId) async {
    return await fireStoreServices.getCollection(
      path: ApiPaths.cartItems(userId),
      builder: (data, documentId) => AddToCartModel.fromMap(data),
    );
  }

  @override
  Future<void> setCartItem(String userId, AddToCartModel cartItem) async {
    await fireStoreServices.setData(
        path: ApiPaths.cartItem(userId, cartItem.id), data: cartItem.toMap());
  }
}
