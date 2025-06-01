import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_app_bar.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/about/presentation/widgets/about_card_list_tile.dart';
import 'package:six_jar/features/splash/presentation/bloc/app_version_bloc.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SixJarAppBar(
        title: "About",
        showBackButton: true,
        onBack: () {
          // Back
          GoRouter.of(context).pop();
        },
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Six Jar Logo
                Icon(Icons.savings, size: 100.h, color: AppColors.primary),

                SizedBox(height: 10.h),

                // Six Jar
                Text(
                  AppTextConstants.appNameText,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),

                SizedBox(height: 16.h),

                // Six Jar Version
                BlocBuilder<AppVersionBloc, AppVersionState>(
                  builder: (context, state) {
                    String versionText = '';
                    if (state is AppVersionLoaded) {
                      versionText = state.version;
                    }
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "${AppTextConstants.appVersionText} $versionText",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 32.h),

                // Privacy Policy
                AboutCardListTile(listTitle: "Privacy Policy", onTap: () {}),

                SizedBox(height: 8.h),

                // About Dev
                AboutCardListTile(listTitle: "About Dev", onTap: () {

                  // Dev PortFolio


                }),

                SizedBox(height: 8.h),

                // Any Bug
                AboutCardListTile(
                  listTitle: "Any Issues Mail Us",
                  onTap: () {


                    // Mail Functionality 



                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
