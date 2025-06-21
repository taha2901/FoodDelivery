import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/utilities/app_colors.dart';
import 'package:food_delivery/core/widgets/loading_indicator.dart';
import 'package:food_delivery/core/widgets/message_display.dart';
import 'package:food_delivery/features/cart/logic/cart/cart_cubit.dart';
import 'package:food_delivery/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:food_delivery/features/home/ui/widgets/food_details.dart/food_item_counter.dart';
import 'package:food_delivery/features/home/ui/widgets/food_details.dart/property_item.dart';

class FoodDetailsPage extends StatefulWidget {
  final String foodIndex;
  const FoodDetailsPage({super.key, required this.foodIndex});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).getCartItems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const LoadingIndicator();
          } else if (state is ProductDetailsError) {
            debugPrint('ssssssssssssssss ${state.message}');
            return MessageDisplay(
              message: state.message,
            );
          } else if (state is ProductDetailsLoaded) {
            final food = state.product;
            return SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, icon: const Icon(Icons.arrow_back_ios)),
                          ),
                          expandedHeight: size.height * 0.35,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.15),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.network(
                                    food.imgUrl,
                                    fit: BoxFit.contain,
                                    height: size.height * 0.28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                            bottom: 46.0,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 6.0),
                                      Text(
                                        'Buffalo Burger',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const FoodItemCounter(),
                                ],
                              ),
                              const SizedBox(height: 32.0),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PropertyItem(
                                        propertyName: 'Size',
                                        propertyValue: food.size),
                                    const VerticalDivider(
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    PropertyItem(
                                        propertyName: 'Calories',
                                        propertyValue:
                                            food.calories.toString()),
                                    const VerticalDivider(
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    const PropertyItem(
                                        propertyName: 'Cooking',
                                        propertyValue: '10-20 Min'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                food.descreption,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Text(
                          '\$ ${food.price}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 46.0),
                        Expanded(
                          child: SizedBox(
                            height: size.height * 0.058,
                            child: BlocBuilder<CartCubit, CartState>(
                              bloc: cartCubit,
                              buildWhen: (previous, current) =>
                                  current is ProductAddedToCart ||
                                  current is ProductAddingToCart,
                              builder: (context, state) {
                                if (state is ProductAddingToCart) {
                                  return ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                    ),
                                    child: const CircularProgressIndicator
                                        .adaptive(),
                                  );
                                }
                        
                                if (state is ProductAddedToCart) {
                                  debugPrint(
                                      "Product added to cart successfully");
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    cartCubit.addToCart(food.id, context);
                                  },
                                  child: const Text('Checkout'),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
