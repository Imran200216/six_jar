import 'package:flutter/material.dart';

class MyExpenseScreen extends StatelessWidget {
  const MyExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("hi my expense"))),
    );
  }
}
