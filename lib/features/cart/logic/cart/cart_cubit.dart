import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/auth_services.dart';
import 'package:food_delivery/core/services/cart_services.dart';
import 'package:food_delivery/core/services/product_details_services.dart';
import 'package:food_delivery/features/cart/data/add_to_cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  final cartServices = CartServicesImp();

  final productDetailsSercices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getCartItems() async {
    emit(CartLoading());
    try {
      final currentUser = authServices.currentUser();
      final cartItems = await cartServices.fetchCartItems(currentUser!.uid);

      emit(CartLoaded(cartItems, _subtotal(cartItems)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    try {
      emit(QuantityCounterLoading());
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      final currentUser = authServices.currentUser();

      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
      emit(QuantityCounterLoaded(
        value: quantity,
        productId: updatedCartItem.product.id,
      ));
      final cartItems = await cartServices.fetchCartItems(currentUser.uid);
      emit(SubtotalUpdated(_subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  Future<void> decrementCounter(AddToCartModel cartItem,
      [int? initialValue]) async {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity--;
    try {
      emit(QuantityCounterLoading());
      final updatedCartItem = cartItem.copyWith(quantity: quantity);
      final currentUser = authServices.currentUser();

      await cartServices.setCartItem(currentUser!.uid, updatedCartItem);
      emit(QuantityCounterLoaded(
        value: quantity,
        productId: updatedCartItem.product.id,
      ));
      final cartItems = await cartServices.fetchCartItems(currentUser.uid);
      emit(SubtotalUpdated(_subtotal(cartItems)));
    } catch (e) {
      emit(QuantityCounterError(e.toString()));
    }
  }

  Future<void> addToCart(String productId, BuildContext context) async {
    emit(ProductAddingToCart());
    try {
      final selectedProduct = await productDetailsSercices.fetchProductDetails(
        productId,
      );

      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: selectedProduct,
        // size: selectedSize!,
        quantity: quantity,
      );

      debugPrint("Adding to cart: ${cartItem.product.name}");

      await productDetailsSercices.addToCart(
          cartItem, authServices.currentUser()!.uid);

      debugPrint("Product added to cart successfully");

      emit(ProductAddedToCart(productId: productId));
    } catch (e) {
      debugPrint("Error adding to cart: $e");
      emit(ProductAddedToCartError(message: "Error: $e"));
    }
  }

  Future<void> deleteItemFromCart(AddToCartModel cartItem) async {
    emit(CartLoading());
    try {
      final currentUser = authServices.currentUser();
      await cartServices.deleteCartItem(currentUser!.uid, cartItem.id);
      final updatedCartItems =
          await cartServices.fetchCartItems(currentUser.uid);
      emit(CartLoaded(updatedCartItems, _subtotal(updatedCartItems)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  double _subtotal(List<AddToCartModel> cartItems) => cartItems.fold<double>(
      0,
      (previousValue, item) =>
          previousValue + (item.product.price * item.quantity));
}
