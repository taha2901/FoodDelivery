import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/routings/routers.dart';
import 'package:food_delivery/core/utilities/app_colors.dart';
import 'package:food_delivery/core/widgets/main_button.dart';
import 'package:food_delivery/features/auth/logic/auth_cubit.dart';
import 'widget/label_with_text_field.dart';
import 'widget/social_media_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start shopping with create your account!',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Username',
                    controller: usernameController,
                    prefixIcon: Icons.person,
                    hintText: 'Enter you username',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                    hintText: 'Enter you email',
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                    label: 'Password',
                    controller: passwordController,
                    prefixIcon: Icons.password,
                    hintText: 'Enter you password',
                    obsecureText: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen: (previous, current) => current is AuthDone ||  current is AuthError,
                    buildWhen: (previous, current) => current is AuthDone || current is AuthLoading || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routers.homeRoute,
                          (route) => false,
                        );
                      }
                      if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                      
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return MainButton( isLoading: true);
                      }
                      return MainButton(
                        text: 'Create Account',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.registerWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                              usernameController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('You have an account? Login'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Or using other method',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: AppColors.grey,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        SocialMediaButton(
                          text: 'Signup with Google',
                          imgUrl:
                              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        SocialMediaButton(
                          text: 'Signup with Facebook',
                          imgUrl:
                              'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
