import 'package:cng/constants/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickerBtn extends StatelessWidget {
  final Function onPressed;
  final String label;
  final IconData icon;
  const PickerBtn({
    this.onPressed,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: accentColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 12.0,
                  offset: const Offset(0, 12.0),
                )
              ],
            ),
            height: 50.0,
            width: 50.0,
            child: Center(
              child: Icon(
                icon,
                color: Colors.black87,
                size: 18.0,
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(label)
        ],
      ),
    );
  }
}

class BtnDark extends StatelessWidget {
  const BtnDark({this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.add, color: Colors.white, size: 15.0),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                "AJOUTER IMAGES",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
