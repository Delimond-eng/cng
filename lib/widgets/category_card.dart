import 'dart:math';

import 'package:cng/models/menu_config_model.dart';

import '../index.dart';

class CategoryCard extends StatelessWidget {
  final Function onPressed;
  final Config data;
  const CategoryCard({
    this.onPressed,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 80.0,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor, primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (data.categorieIcon != null &&
                    data.categorieIcon.isNotEmpty) ...[
                  SvgPicture.network(
                    data.categorieIcon.replaceAll("https", "http"),
                    color: Colors.white,
                    height: 25.0,
                    width: 25.0,
                  )
                ] else ...[
                  SvgPicture.asset(
                    "assets/icons/data-svgrepo-com.svg",
                    color: Colors.white,
                    height: 20.0,
                    width: 20.0,
                  )
                ],
                const SizedBox(
                  height: 8.0,
                ),
                Flexible(
                  child: Text(
                    data.categorie,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
