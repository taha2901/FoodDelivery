import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';
import 'package:food_delivery/features/home/logic/home/home_cubit.dart';

class FoodGridItem extends StatelessWidget {
  final int foodIndex;
  final List<FoodItemModel> filteredFood;
  const FoodGridItem({
    super.key,
    required this.foodIndex,
    required this.filteredFood,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    // final targettedIndex = filteredFood.indexOf(filteredFood[foodIndex]);
    // final size = MediaQuery.of(context).size;
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
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    filteredFood[foodIndex].imgUrl,
                    height: constraints.maxHeight * 0.55,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: homeCubit,
                    buildWhen: (previous, current) =>
                         (current is SetFavouriteFailure &&
                          current.productId == filteredFood[foodIndex].id) ||
                      (current is SetFavouriteLoading &&
                          current.productId == filteredFood[foodIndex].id) ||
                      (current is SetFavouriteSuccess &&
                          current.productId == filteredFood[foodIndex].id),
                    builder: (context, state) {
                      if (state is SetFavouriteLoading) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (state is SetFavouriteSuccess) {
                        return state.isFav
                            ? InkWell(
                                onTap: () async => await homeCubit.setFavourite(
                                    filteredFood[foodIndex], context),
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              )
                            : InkWell(
                                onTap: () async => await homeCubit.setFavourite(
                                    filteredFood[foodIndex], context),
                                child: const Icon(
                                  Icons.favorite_border,
                                ),
                              );
                      }

                      return InkWell(
                        onTap: () async => await homeCubit.setFavourite(
                            filteredFood[foodIndex], context),
                        child: filteredFood[foodIndex].isFavorite
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                              ),
                      );
                    },
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
