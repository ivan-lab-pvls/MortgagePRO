import 'package:flats/screens/i_screen/widgets/second_on_boarding_card.dart';
import 'package:flutter/material.dart';

class SecondOnBoardingBody extends StatelessWidget {
  const SecondOnBoardingBody({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            'assets/stars.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        SecondOnBoardingCard(onTap: onTap),
      ],
    );
  }
}
