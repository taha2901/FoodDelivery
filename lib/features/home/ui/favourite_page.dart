import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';
import 'package:food_delivery/features/home/data/models/ui_models/food_details_args.dart';
import 'package:food_delivery/features/home/ui/food_details_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteFood =
        food.where((foodItem) => foodItem.isFavorite == true).toList();
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (favoriteFood.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_state.png',
                  fit: BoxFit.cover,
                  height: constraints.maxHeight * 0.5,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Text(
                  'No Favorite Items Found!',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        },
      );
    }

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: favoriteFood.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                debugPrint(food[index].name);
                int targettedIndex = food.indexOf(favoriteFood[index]);
                Navigator.of(context).pushNamed(
                 FoodDetailsPage.routeName,
                  arguments: FoodDetailsArgs(foodIndex: targettedIndex),
                ).then((value) {
                  setState(() {});
                  debugPrint("The value returned in Favorites Page is $value");
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.network(
                        favoriteFood[index].imgUrl,
                        height:
                            isLandScape ? size.height * 0.2 : size.height * 0.1,
                        width: size.width * 0.22,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8.0),
                      // النصوص
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favoriteFood[index].name,
                              style: isLandScape
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: size.height * 0.03,
                                      ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '\$ ${favoriteFood[index].price}',
                              style: isLandScape
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      )
                                  : Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      AdaptiveFavButton(
                          favoriteFood, index, context, isLandScape, size),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  IconButton AdaptiveFavButton(List<FoodItem> favoriteFood, int index,
      BuildContext context, bool isLandScape, Size size) {
    return IconButton(
      onPressed: () {
        final targetedItem = favoriteFood[index];
        int targetedIndex = food.indexOf(targetedItem);
        setState(() {
          food[targetedIndex] = food[targetedIndex].copyWith(isFavorite: false);
        });
      },
      icon: Icon(
        Icons.favorite,
        color: Theme.of(context).primaryColor,
        size: isLandScape ? size.height * 0.1 : size.height * 0.04,
      ),
    );
  }
}
