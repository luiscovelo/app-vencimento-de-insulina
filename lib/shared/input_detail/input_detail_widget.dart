import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputDetailWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;
  const InputDetailWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Icon(icon),
            ),
          ),
          Text.rich(
            TextSpan(
              text: label + "\n",
              children: [
                TextSpan(
                  text: text,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
