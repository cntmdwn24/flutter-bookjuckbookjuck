import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(70),
        image: const DecorationImage(
          image: AssetImage('assets/images/curry.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
