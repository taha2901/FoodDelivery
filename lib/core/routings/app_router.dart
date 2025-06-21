import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/routings/routers.dart';
import 'package:food_delivery/core/widgets/cutome_bottom_nav_bar.dart';
import 'package:food_delivery/features/auth/logic/auth_cubit.dart';
import 'package:food_delivery/features/auth/ui/register_page.dart';
import 'package:food_delivery/features/cart/logic/cart/cart_cubit.dart';
import 'package:food_delivery/features/home/data/models/ui_models/food_details_args.dart';
import 'package:food_delivery/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:food_delivery/features/home/ui/food_details_page.dart';
import 'package:food_delivery/features/profile/ui/widget/user_profile.dart';
import '../../features/auth/ui/login_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routers.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );

      case Routers.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginPage(),
          ),
          settings: settings,
        );

      case Routers.registerRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const RegisterPage(),
          ),
        );

      case Routers.productDetailsRoute:
        final FoodDetailsArgs args = settings.arguments as FoodDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductDetailsCubit()
                  ..getProductDetails(args.foodIndex.toString()),
              ),
              BlocProvider(
                create: (context) => CartCubit(),
              ),
            ],
            child: FoodDetailsPage(foodIndex: args.foodIndex),
          ),
          settings: settings,
        );

      case Routers.userProfileRoute:
        return MaterialPageRoute(
          builder: (_) => const UserProfilePage(),
          settings: settings,
        );

      // case Routers.checkoutPaymentRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => const MyCartView(),
      //     settings: settings,
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error Page')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
