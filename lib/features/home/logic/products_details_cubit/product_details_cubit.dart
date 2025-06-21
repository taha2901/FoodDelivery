import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/auth_services.dart';
import 'package:food_delivery/core/services/product_details_services.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  int quantity = 1;

  final productDetailsSercices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();

  Future<void> getProductDetails(String id) async {
    emit(ProductDetailsLoading());

    try {
      final selectedProduct =
          await productDetailsSercices.fetchProductDetails(id);

      emit(ProductDetailsLoaded(product: selectedProduct));
    } catch (e) {
      emit(ProductDetailsError(message: "Error: $e"));
    }
  }

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }



  
}
