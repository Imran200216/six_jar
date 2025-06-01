import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/constants/app_assets_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_drawer_list_tile.dart';
import 'package:six_jar/features/splash/presentation/bloc/app_version_bloc.dart';

class SixJarDrawer extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userImageUrl;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;
  final VoidCallback onAboutTap;
  final VoidCallback onMyExpenseTap;

  const SixJarDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userImageUrl,
    required this.onSettingsTap,
    required this.onLogoutTap,
    required this.onAboutTap,
    required this.onMyExpenseTap,
  });

  @override
  State<SixJarDrawer> createState() => _SixJarDrawerState();
}

class _SixJarDrawerState extends State<SixJarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          _buildHeader(context),


          // About
          SixJarDrawerListTile(
            onTap: widget.onAboutTap,
            drawerTitle: "About",
            drawerIcon: Icons.info,
          ),

          // My Expenses
          SixJarDrawerListTile(
            onTap: widget.onMyExpenseTap,
            drawerTitle: "My Expense",
            drawerIcon: Icons.wallet_rounded,
          ),

          // Settings
          SixJarDrawerListTile(
            onTap: widget.onSettingsTap,
            drawerTitle: "Settings",
            drawerIcon: Icons.settings,
          ),

          // Logout
          SixJarDrawerListTile(
            onTap: widget.onLogoutTap,
            drawerTitle: "Logout",
            drawerIcon: Icons.logout,
          ),

          const Spacer(),

          // App Version
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: BlocBuilder<AppVersionBloc, AppVersionState>(
              builder: (context, state) {
                String versionText = '';
                if (state is AppVersionLoaded) {
                  versionText = state.version;
                }
                return Text(
                  "${AppTextConstants.appVersionText} $versionText",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 230.h,
      color: AppColors.primary,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Avatar
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 40.r,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.userImageUrl,
                width: 80.r,
                height: 80.r,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  AppAssetsConstants.profilePlaceHolderImg,
                  width: 40.r,
                  height: 40.r,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppAssetsConstants.profilePlaceHolderImg,
                  width: 40.r,
                  height: 40.r,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // username
          Text(
            widget.userName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.background,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),

          // user email
          Text(
            widget.userEmail,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.background,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
