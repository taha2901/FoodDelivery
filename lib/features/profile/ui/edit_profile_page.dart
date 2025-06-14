import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/ui/widget/label_with_text_field.dart';
import 'package:iconsax/iconsax.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final googleController = TextEditingController();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            title: const Text('Edit Profile'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.5),
              child: Container(
                color: Colors.grey.shade300,
                height: 1.5,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Iconsax.more),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: Column(children: [
          const SizedBox(
            height: 20.0,
          ),
          const CircleAvatar(
            radius: 60.0,
            backgroundImage: NetworkImage(
                'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg'),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text('Username'),
          LabelWithTextField(
              label: 'Taha Hamada',
              controller: usernameController,
              prefixIcon: Iconsax.profile_2user1,
              hintText: ''),
          const Text('Email Or Phone number'),
          LabelWithTextField(
              label: 'tahahamada2901@gmail.com',
              controller: emailController,
              prefixIcon: Icons.email_outlined,
              hintText: ''),
          const Text('Account Liked With'),
          LabelWithTextField(
              label: 'Google',
              controller: googleController,
              prefixIcon: Icons.social_distance_outlined,
              hintText: ''),
        ]));
  }
}
