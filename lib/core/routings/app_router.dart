import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/routings/routers.dart';
import 'package:food_delivery/core/widgets/cutome_bottom_nav_bar.dart';
import 'package:food_delivery/features/auth/logic/auth_cubit.dart';
import 'package:food_delivery/features/auth/ui/register_page.dart';
import 'package:food_delivery/features/home/data/models/ui_models/food_details_args.dart';
import 'package:food_delivery/features/home/logic/products_details_cubit/product_details_cubit.dart';
import 'package:food_delivery/features/home/ui/food_details_page.dart';
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

      // case Routers.checkoutRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => const CheckoutPage(),
      //     settings: settings,
      //   );

      // case Routers.chooseLocation:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) {
      //         final cubit = ChooseLocationCubit();
      //         cubit.fetchLocations();
      //         return cubit;
      //       },
      //       child: const ChooseLocationPage(),
      //     ),
      //     settings: settings,
      //   );
      // case Routers.addNewCardRoute:
      //   final paymentCubit = settings.arguments as PaymentCubit;
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: paymentCubit,
      //       child: const AddNewCardPage(),
      //     ),
      //     settings: settings,
      //   );

      case Routers.productDetailsRoute:
        final FoodDetailsArgs args = settings.arguments as FoodDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductDetailsCubit()
              ..getProductDetails(args.foodIndex.toString()),
            child: FoodDetailsPage(foodIndex: args.foodIndex),
          ),
          settings: settings,
        );

      // case Routers.editProfileRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => Container(),
      //     settings: settings,
      //   );

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
