import 'package:flutter/material.dart';
import 'package:food_delivery/core/utilities/app_assets.dart';
import 'package:food_delivery/features/home/data/models/category_item.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';
import 'package:food_delivery/features/home/data/models/ui_models/food_details_args.dart';
import 'package:food_delivery/features/home/ui/food_details_page.dart';
import 'package:food_delivery/features/home/ui/widgets/food_grid_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? categoryChosenId;
  late List<FoodItem> filteredFood;
  bool enableCategoryFilter = false;

  @override
  void initState() {
    super.initState();
    filteredFood = food;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Image.asset(
                  AppAssets.burgerBanner,
                  width: constraints.maxWidth * 1,
                  fit: BoxFit.cover,
                ),
              );
            }),
            SizedBox(height: size.height * 0.04),
            SizedBox(
              height: size.height * 0.17,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: 16.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (categoryChosenId == categories[index].id || 
                            categoryChosenId == false) {
                          enableCategoryFilter = !enableCategoryFilter;
                        }
                        if (!enableCategoryFilter) {
                          categoryChosenId = null;
                          filteredFood = food;
                        } else {
                          categoryChosenId = categories[index].id;
                          filteredFood = food
                              .where((foodItem) =>
                                  foodItem.categoryId == categoryChosenId)
                              .toList();
                        }
                      });
                      debugPrint(categoryChosenId);
                    },
                    child: Container(
                      width: size.width * 0.25,
                      decoration: BoxDecoration(
                        color: categoryChosenId == categories[index].id
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(categories[index].imgPath,
                                height: size.height * 0.06),
                            const SizedBox(height: 4.0),
                            Text(
                              categories[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color:
                                        categoryChosenId == categories[index].id
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredFood.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLandScape ? 3 : 2,
                mainAxisSpacing: size.height * 0.02,
                crossAxisSpacing: size.height * 0.02,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  final targettedFoodItem = food.firstWhere(
                      (foodItem) => foodItem.id == filteredFood[index].id);
                  final targettedIndex = food.indexOf(targettedFoodItem);
                  debugPrint(food[index].name);
                  Navigator.of(context)
                      .pushNamed(
                    FoodDetailsPage.routeName,
                    arguments: FoodDetailsArgs(foodIndex: targettedIndex),
                  )
                      .then((value) {
                    setState(() {});
                    filteredFood = food;
                    categoryChosenId = null;
                    debugPrint("The value returned in Home Page is $value");
                  });
                },
                child: FoodGridItem(
                  foodIndex: index,
                  filteredFood: filteredFood,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
