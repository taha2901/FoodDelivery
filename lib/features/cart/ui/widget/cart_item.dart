import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/utilities/app_colors.dart';
import 'package:food_delivery/features/cart/data/add_to_cart.dart';
import 'package:food_delivery/features/cart/logic/cart/cart_cubit.dart';
import 'package:food_delivery/features/home/ui/widgets/food_details.dart/counter_widget.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.grey2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: cartItem.product.imgUrl,
              height: 125,
              width: 125,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text.rich(
                  TextSpan(
                    text: 'Size: ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.grey,
                        ),
                    children: [
                      // TextSpan(
                      //   text: cartItem.size.name,
                      //   style: Theme.of(context).textTheme.titleMedium,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is QuantityCounterLoaded &&
                      current.productId == cartItem.product.id,
                  builder: (context, state) {
                    if (state is QuantityCounterLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            value: state.value,
                            productId: cartItem.product.id,
                            cubit: cubit,
                            cartItem: cartItem,
                          ),
                          Text(
                            '\$${(state.value * cartItem.product.price).toStringAsFixed(1)}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          value: cartItem.quantity,
                          productId: cartItem.product.id,
                          cubit: cubit,
                          initialValue: cartItem.quantity,
                          cartItem: cartItem,
                        ),
                        Text(
                          '\$${cartItem.totalPrice.toStringAsFixed(1)}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}