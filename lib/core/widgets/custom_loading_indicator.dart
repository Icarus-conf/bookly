import 'package:flutter/material.dart';

class CustomLoadingInicator extends StatelessWidget {
  const CustomLoadingInicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
