import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/profile/logic/user_cubit/user_cubit.dart';
import 'package:food_delivery/features/profile/logic/user_cubit/user_states.dart';
import 'package:food_delivery/features/profile/ui/edit_profile_page.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(title: const Text('الملف الشخصي')),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("👤 الاسم: ${user.username}"),
                    Text("📧 البريد: ${user.email}"),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<UserCubit>(), // ← ده مهم جدًا
                            child: EditProfilePage(user: user),
                          ),
                        ),
                      );
                      },
                      label: const Text("تعديل البيانات"),
                    )
                  ],
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
