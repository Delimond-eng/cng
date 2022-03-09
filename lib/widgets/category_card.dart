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
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: primaryColor.withOpacity(.3),
          width: .5,
        ),
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
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)]
                        .shade900,
                    height: 40.0,
                    width: 40.0,
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
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
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
