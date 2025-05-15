import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 300.h,
            backgroundColor: AppColors.primary,
            leading: Icon(Icons.menu, color: AppColors.background),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                AppTextConstants.appNameText,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.background,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              background: Container(color: AppColors.primary),
            ),
          ),

          // Content Section
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Jar 1: Necessities
                    SixJarContainer(
                      jarName: "Necessities",
                      amount: "Rs. 400",
                      color: Colors.blueAccent,
                      icon: Icons.shopping_cart,
                    ),
                    SizedBox(height: 16.h),

                    // Jar 2: Financial Freedom
                    SixJarContainer(
                      jarName: "Financial Freedom",
                      amount: "Rs. 100",
                      color: Colors.green,
                      icon: Icons.attach_money,
                    ),
                    SizedBox(height: 16.h),

                    // Jar 3: Education
                    SixJarContainer(
                      jarName: "Education",
                      amount: "Rs. 100",
                      color: Colors.orange,
                      icon: Icons.school,
                    ),
                    SizedBox(height: 16.h),

                    // Jar 4: Long-term Savings
                    SixJarContainer(
                      jarName: "Savings",
                      amount: "Rs. 100",
                      color: Colors.purple,
                      icon: Icons.savings,
                    ),
                    SizedBox(height: 16.h),

                    // Jar 5: Play
                    SixJarContainer(
                      jarName: "Play",
                      amount: "Rs. 100",
                      color: Colors.redAccent,
                      icon: Icons.sports_esports,
                    ),
                    SizedBox(height: 16.h),

                    // Jar 6: Give
                    SixJarContainer(
                      jarName: "Give",
                      amount: "Rs. 100",
                      color: Colors.teal,
                      icon: Icons.volunteer_activism,
                    ),
                    SizedBox(height: 50.h),

                    // Jar 6: Give
                    SixJarContainer(
                      jarName: "Give",
                      amount: "Rs. 100",
                      color: Colors.teal,
                      icon: Icons.volunteer_activism,
                    ),

                    // Jar 6: Give
                    SixJarContainer(
                      jarName: "Give",
                      amount: "Rs. 100",
                      color: Colors.teal,
                      icon: Icons.volunteer_activism,
                    ),

                    // Jar 6: Give
                    SixJarContainer(
                      jarName: "Give",
                      amount: "Rs. 100",
                      color: Colors.teal,
                      icon: Icons.volunteer_activism,
                    ),

                    // Jar 6: Give
                    SixJarContainer(
                      jarName: "Give",
                      amount: "Rs. 100",
                      color: Colors.teal,
                      icon: Icons.volunteer_activism,
                    ),

                    // Jar 6: Give
                    SixJarContainer(
                      jarName: "Give",
                      amount: "Rs. 100",
                      color: Colors.teal,
                      icon: Icons.volunteer_activism,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
