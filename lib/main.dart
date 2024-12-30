import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/features/home/ui/bottom_nav_bar.dart';
import 'package:food_delivery/features/home/ui/food_details_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodak - Food Delivery',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        dividerTheme: const DividerThemeData(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        listTileTheme: const ListTileThemeData(iconColor: Colors.deepOrange),
        fontFamily: 'OpenSans',
      ),
      routes: {
        '/': (context) => const BottomNavBarPage(),
        FoodDetailsPage.routeName: (context) => const FoodDetailsPage(),
      },
    );
  }
}
