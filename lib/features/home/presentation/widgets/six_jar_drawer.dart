import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/constants/app_assets.constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImageUrl;
  final VoidCallback onHomeTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const SixJarDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userImageUrl,
    required this.onHomeTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 100.r,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: userImageUrl,
                  width: 80.r,
                  height: 80.r,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    AppAssetsConstants.profilePlaceHolderImg,
                    width: 80.r,
                    height: 80.r,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppAssetsConstants.profilePlaceHolderImg,
                    width: 80.r,
                    height: 80.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            accountName: Text(userName),
            accountEmail: Text(userEmail),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onHomeTap();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              onSettingsTap();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              onLogoutTap();
            },
          ),
        ],
      ),
    );
  }
}
