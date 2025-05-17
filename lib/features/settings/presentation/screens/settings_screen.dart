import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SixJarAppBar(
        title: "Settings",
        showBackButton: true,
        onBack: () {
          // Back
          GoRouter.of(context).pop();
        },
      ),
      body: SafeArea(child: Center(child: Text("hi settings"))),
    );
  }
}
