import 'package:food_delivery/features/home/data/models/food_item.dart';

class AddToCartModel {
  final String id;
  final FoodItemModel product;
  // final ProductSize size;
  final int quantity;

  const AddToCartModel({
    required this.id,
    required this.product,
    // required this.size,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;

  AddToCartModel copyWith({
    String? id,
    FoodItemModel? product,
    // ProductSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      // size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'product': product.toMap()});
    // result.addAll({'size': size.name});
    result.addAll({'quantity': quantity});
  
    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] ?? '',
      product: FoodItemModel.fromMap(map['product'] , map['id']),
      // size: ProductSize.fromString(map['size']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }
}

List<AddToCartModel> dummyCart = [];