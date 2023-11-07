import 'package:flats/screens/i_screen/widgets/first_on_boarding_card.dart';
import 'package:flutter/material.dart';

class FirstOnBoardingBody extends StatelessWidget {
  const FirstOnBoardingBody({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            'assets/money_bag.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        FirstOnBoardingCard(onTap: onTap),
      ],
    );
  }
}
