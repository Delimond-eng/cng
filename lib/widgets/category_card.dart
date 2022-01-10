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
      margin: const EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/shapes/shapebg.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 10.0,
            offset: const Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.9),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30.0),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data.categorieIcon.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.network(
                        data.categorieIcon,
                        color: primaryColor,
                        height: 30.0,
                        width: 30.0,
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/data-svgrepo-com.svg",
                        color: Colors.grey[100],
                        height: 20.0,
                        width: 20.0,
                      ),
                    ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    data.categorie,
                    style: GoogleFonts.lato(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
