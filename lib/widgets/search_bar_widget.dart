import 'package:flutter/cupertino.dart';

import '../index.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const SearchBar({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10.0, right: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0.0, 10.0),
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.lato(fontSize: 14.0),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "recherche",
          contentPadding: const EdgeInsets.only(top: 15, bottom: 8),
          hintStyle: GoogleFonts.lato(color: Colors.black38),
          icon: Icon(
            CupertinoIcons.search,
            color: primaryColor,
            size: 20,
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              "assets/icons/settings-svgrepo-com.svg",
              fit: BoxFit.cover,
              height: 20.0,
              width: 20.0,
              color: Colors.grey,
            ),
          ),
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }
}
