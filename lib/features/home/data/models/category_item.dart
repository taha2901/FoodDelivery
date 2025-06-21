import 'dart:convert';

class CategoryItemModel {
  final String id;
  final String title;
  final String imgPath;


  CategoryItemModel({
    required this.id,
    required this.title,
    required this.imgPath,
    
  });

  // fromMap
  factory CategoryItemModel.fromMap(Map<String, dynamic> map) {
    return CategoryItemModel(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        imgPath: map['imgPath'] ?? '',
        
        );
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imgPath': imgPath,
          };
  }

  // fromJson
  factory CategoryItemModel.fromJson(String source) {
    return CategoryItemModel.fromMap(json.decode(source));
  }

  // toJson
  String toJson() => json.encode(toMap());
}

// final List<CategoryItemModel> categories = [
//   CategoryItemModel(id: '1', title: 'Burger', imgPath: AppAssets.burgerIcon),
//   CategoryItemModel(id: '2', title: 'Pizza', imgPath: AppAssets.pizzaIcon),
//   CategoryItemModel(id: '3', title: 'Pasta', imgPath: AppAssets.pastaIcon),
//   CategoryItemModel(id: '4', title: 'Pasta', imgPath: AppAssets.pastaIcon),
//   CategoryItemModel(id: '5', title: 'Pasta', imgPath: AppAssets.pastaIcon),
//   CategoryItemModel(id: '6', title: 'Pasta', imgPath: AppAssets.pastaIcon),
// ];
