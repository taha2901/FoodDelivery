import 'package:flutter/material.dart';
import 'package:food_delivery/core/utilities/app_assets.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Widget orderVoucherItem(BuildContext context,
      {required String name, required int number}) {
    return Column(
      children: [
        Text(number.toString(),
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Theme.of(context).primaryColor)),
        Text(name, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget itemTappedTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData icon,
  }) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ListTile(
      title: Text(title),
      leading: Icon(
        icon,
        size: isLandScape ? size.height * 0.1 : size.height * 0.03,
      ),
      onTap: () => debugPrint('$title clicked!'),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Icon(
        Icons.chevron_right,
        size: isLandScape ? size.height * 0.1 : size.height * 0.03,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final nameText = Text(
      'Tarek Alabd',
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            if (!isLandScape) ...[
              PersonPhoto(
                  height: size.height * 0.3,
                  width: size.width * 0.5,
                  isLandScape: isLandScape,
                  size: size),
              nameText,
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  orderVoucherItem(context, name: 'Orders', number: 50),
                  orderVoucherItem(context, name: 'Vouchers', number: 10),
                ],
              ),
              const SizedBox(height: 24.0),
            ],
            if (isLandScape) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      PersonPhoto(
                          height: size.height * 0.25,
                          width: size.width * 0.5,
                          isLandScape: isLandScape,
                          size: size),
                      const SizedBox(
                        height: 8.0,
                      ),
                      nameText,
                    ],
                  ),
                  Column(
                    children: [
                      orderVoucherItem(context, name: 'Orders', number: 50),
                      const SizedBox(
                        height: 16,
                      ),
                      orderVoucherItem(context, name: 'Vouchers', number: 10),
                    ],
                  ),
                ],
              )
            ],
            const Divider(),
            itemTappedTile(context,
                title: 'Past Orders', icon: Icons.shopping_cart),
            const Divider(),
            itemTappedTile(context,
                title: 'Available Vouchers', icon: Icons.card_giftcard),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class PersonPhoto extends StatelessWidget {
  const PersonPhoto({
    super.key,
    required this.isLandScape,
    required this.size,
    required this.width,
    required this.height,
  });

  final bool isLandScape;
  final Size size;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            AppAssets.profilePhoto,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
