import 'package:flutter/material.dart';

class WaveHeader extends StatelessWidget {
  const WaveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Image.asset(
        'assets/images/volna.png',
        fit: BoxFit.fitWidth,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
