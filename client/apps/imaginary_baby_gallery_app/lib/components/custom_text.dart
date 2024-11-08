import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String main;
  final String sub;
  const CustomText({
    super.key,
    required this.main,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          main,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          sub,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
