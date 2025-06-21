import 'dart:convert';

class FoodItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final double price;
  bool isFavorite;
  final String categoryId;
  final int calories;
  final String size;
  final String descreption;

  FoodItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.price,
    this.isFavorite = false,
    required this.categoryId,
    required this.calories,
    required this.size,
    required this.descreption,
  });

  // ✅ copyWith
  FoodItemModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    double? price,
    bool? isFavorite,
    String? categoryId,
    int? calories,
    String? size,
    String? descreption
  }) {
    return FoodItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      categoryId: categoryId ?? this.categoryId,
      calories: calories ?? this.calories,
      size: size ?? this.size,
      descreption: descreption ?? this.descreption
    );
  }

  // ✅ fromMap
  factory FoodItemModel.fromMap(Map<String, dynamic> map, String? documentId) {
    return FoodItemModel(
      id: documentId ?? '',
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      isFavorite: map['isFavorite'] ?? false,
      categoryId: map['categoryId'] ?? '',
      calories: map['calories'] ?? '',
        descreption: map['descreption'] ??'',
        size: map['size'] ??'',
    );
  }

  // ✅ toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'price': price,
      'isFavorite': isFavorite,
      'categoryId': categoryId,
      'calories': calories,
      'descreption':descreption,
      'size':size,
    };
  }

  // ✅ fromJson
  factory FoodItemModel.fromJson(String source) =>
      FoodItemModel.fromMap(json.decode(source) as Map<String, dynamic>, null);

  // ✅ toJson
  String toJson() => json.encode(toMap());
}


// List<FoodItemModel> food = [
//   FoodItemModel(
//     id: 'burger 1',
//     name: 'Beef Burger',
//     imgUrl:
//         'https://www.freepnglogos.com/uploads/burger-png/download-hamburger-burger-png-image-png-image-pngimg-15.png',
//     price: 8.5,
//     categoryId: '1',
//   ),
//   FoodItemModel(
//     id:  'burger 2',
//     name: 'Chicken Burger',
//     imgUrl: 'https://www.pngarts.com/files/3/Chicken-Burger-PNG-Photo.png',
//     price: 8.5,
//     categoryId: '1',
//   ),
//   FoodItemModel(
//     id: 'burger 3',
//     name: 'Cheese Burger',
//     imgUrl:
//         'https://www.pngmart.com/files/16/Cheese-Burger-PNG-Transparent-Image.png',
//     price: 8,
//     categoryId: '1',
//   ),
//   FoodItemModel(
//     id: 'pizza 1',
//     name: 'Chicken Pizza',
//     imgUrl:
//         'https://graficsea.com/wp-content/uploads/2021/12/Chicken-Supreme-Pizza-.png',
//     price: 9,
//     categoryId: '2',
//   ),
//   FoodItemModel(
//     id: 'pasta 1',
//     name: 'Pasta',
//     imgUrl:
//         'https://www.pngall.com/wp-content/uploads/2018/04/Pasta-PNG-Image.png',
//     price: 7,
//     categoryId: '3',
//   ),
//   FoodItemModel(
//     id: 'Pasta 2',
//     name: 'Pasta2',
//     imgUrl:
//         'https://www.pngall.com/wp-content/uploads/2018/04/Pasta-PNG-Image.png',
//     price: 7,
//     categoryId: '4',
//   ),
//   FoodItemModel(
//     id: 'Pasta 3',
//     name: 'Pasta3',
//     imgUrl:
//         'https://www.pngall.com/wp-content/uploads/2018/04/Pasta-PNG-Image.png',
//     price: 7,
//     categoryId: '5',
//   ),
//   FoodItemModel(
//     id: 'Pasta 4',
//     name: 'Pasta4',
//     imgUrl:
//         'https://www.pngall.com/wp-content/uploads/2018/04/Pasta-PNG-Image.png',
//     price: 7,
//     categoryId: '6',
//   ),
// ];
