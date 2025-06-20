import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/utilities/app_colors.dart';
import 'package:food_delivery/features/cart/logic/cart/cart_cubit.dart';
import 'package:food_delivery/features/cart/ui/cart_page.dart';
import 'package:food_delivery/features/favourite/logic/cubit/favourite_cubit.dart';
import 'package:food_delivery/features/favourite/ui/favourite_page.dart';
import 'package:food_delivery/features/home/logic/home/home_cubit.dart';
import 'package:food_delivery/features/home/ui/home_page.dart';
import 'package:food_delivery/features/profile/ui/profile_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() {
    return [
      BlocProvider(
        create: (context) => HomeCubit()
          ..getHomeData()
          ..getCategoryData(),
        child: const HomePage(),
      ),
      BlocProvider(
        create: (context) => CartCubit()..getCartItems(),
        child: const CartPage(),
      ),
      BlocProvider(
        create: (context) => FavouriteCubit()..getFavoriteProducts(),
        child: const FavoritesPage(),
      ),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: "Home",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: "Cart",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.heart),
        title: "Favorites",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: "Profile",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: AppColors.grey,
      ),
    ];
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 3
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                leading: currentIndex == 3
                    ? null
                    : const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg'),
                        ),
                      ),
                title: currentIndex == 3
                    ? null
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Taha Hamada',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            'Let\'s go shopping!',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                actions: [
                  if (currentIndex == 0) ...[
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                  ] else if (currentIndex == 1)
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.shopping_bag))
                ],
              ),
            ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        onItemSelected: (value) {
          setState(() {
            currentIndex = value;
            debugPrint('Current Index is $currentIndex');
          });
        },
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
