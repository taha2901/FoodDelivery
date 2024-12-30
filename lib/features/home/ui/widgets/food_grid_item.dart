import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';
import 'package:food_delivery/features/home/ui/widgets/favourite_butons.dart';

class FoodGridItem extends StatelessWidget {
  final int foodIndex;
  final List<FoodItem> filteredFood;
  const FoodGridItem({
    super.key,
    required this.foodIndex,
    required this.filteredFood,
  });

  @override
  Widget build(BuildContext context) {
    final targettedIndex = food.indexOf(filteredFood[foodIndex]);
    final size = MediaQuery.of(context).size;
    final textScaler = MediaQuery.textScalerOf(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.network(
                    filteredFood[foodIndex].imgUrl,
                    height: constraints.maxHeight * 0.55,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FavoriteButton(
                      height: constraints.maxHeight * 0.1,
                      width: constraints.maxWidth * 0.1,
                      foodIndex: targettedIndex,
                    ),
                  ),
                ],
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              SizedBox(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(filteredFood[foodIndex].name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: textScaler.scale(16),
                          )),
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              Text('\$ ${filteredFood[foodIndex].price}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: textScaler.scale(18),
                      )),
            ],
          );
        }),
      ),
    );
  }
}
