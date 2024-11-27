import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtons extends StatelessWidget {
  ///Padding: Applies to only left and right, defaults to 20
  final double padding;

  ///Text: The name of the button
  final String text;

  ///ontap: Function()? determines what should be done when the button is tapped on
  final Function()? onTap;
  const CustomButtons(
      {super.key, required this.text, required this.onTap, this.padding = 20});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding, bottom: 10),
        child: Container(
          height: 55,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
