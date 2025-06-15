import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/routings/routers.dart';
import 'package:food_delivery/core/utilities/app_assets.dart';
import 'package:food_delivery/features/home/data/models/category_item.dart';
import 'package:food_delivery/features/home/data/models/food_item.dart';
import 'package:food_delivery/features/home/data/models/ui_models/food_details_args.dart';
import 'package:food_delivery/features/home/logic/home/home_cubit.dart';
import 'package:food_delivery/features/home/ui/widgets/food_grid_item.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodItemModel> allFood = [];
  List<CategoryItemModel> filteredCategories = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        } else if (state is HomeLoaded) {
          setState(() {
            allFood = state.products;
          });
        } else if (state is CategoryLoaded) {
          setState(() {
            filteredCategories = state.categories;
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        AppAssets.burgerBanner,
                        width: constraints.maxWidth,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.04),

                /// ✅ Category section
                filteredCategories.isEmpty
                    ? _buildCategoriesShimmer(context)
                    : _buildCategoryList(context),

                SizedBox(height: size.height * 0.04),

                /// ✅ Food section
                allFood.isEmpty
                    ? _buildFoodShimmer(context, isLandscape)
                    : _buildFoodGrid(context, isLandscape),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ✅ Category UI
  Widget _buildCategoryList(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.17,
      child: ListView.builder(
        itemCount: filteredCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = filteredCategories[index];

          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(
                        category.imgPath,
                        height: size.height * 0.06,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        category.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ✅ Category shimmer
  Widget _buildCategoriesShimmer(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.17,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: size.width * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ✅ Food grid
  Widget _buildFoodGrid(
    BuildContext context,
    bool isLandscape,
  ) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allFood.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 4 : 2,
        mainAxisSpacing: size.height * 0.02,
        crossAxisSpacing: size.height * 0.02,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context,rootNavigator: true).pushNamed(
              
              Routers.productDetailsRoute,
              arguments: FoodDetailsArgs(foodIndex: index),
            );
          },
          child: FoodGridItem(
            foodIndex: index,
            filteredFood: allFood,
          ),
        );
      },
    );
  }

  /// ✅ Food shimmer
  Widget _buildFoodShimmer(BuildContext context, bool isLandscape) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 4 : 2,
        mainAxisSpacing: size.height * 0.02,
        crossAxisSpacing: size.height * 0.02,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        );
      },
    );
  }
}
