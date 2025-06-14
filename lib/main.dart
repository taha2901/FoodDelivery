import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/routings/app_router.dart';
import 'package:food_delivery/core/routings/routers.dart';
import 'package:food_delivery/features/auth/logic/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authCubit = AuthCubit();
        authCubit.checkAuth();
        return authCubit;
      },
      child: Builder(builder: (context) {
        final authCubit = BlocProvider.of<AuthCubit>(context);
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          buildWhen: (previous, current) =>
              current is AuthDone || current is AuthInitial,
          builder: (context, state) {
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
                listTileTheme:
                    const ListTileThemeData(iconColor: Colors.deepOrange),
                fontFamily: 'OpenSans',
              ),
              initialRoute:
                  state is AuthDone ? Routers.homeRoute : Routers.loginRoute,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        );
      }),
    );
  }
}
