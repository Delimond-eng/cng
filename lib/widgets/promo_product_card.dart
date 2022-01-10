import 'dart:convert';

import 'package:cng/models/products_model.dart';

import '../index.dart';

class PromoProductCard extends StatelessWidget {
  const PromoProductCard({this.onPressed, this.product});

  final Product product;

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // ignore: deprecated_member_use
      overflow: Overflow.visible,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: .5),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 12.0,
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 12),
              )
            ],
          ),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: (product.image != null)
                      ? DecorationImage(
                          image: MemoryImage(base64Decode(product.image)),
                          fit: BoxFit.cover,
                          scale: 2.0,
                          alignment: Alignment.topCenter,
                        )
                      : const DecorationImage(
                          image: AssetImage("assets/shapes/placeholder.png"),
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.5),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            product.titre,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: onPressed,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Center(
                                  child: Text(
                                    "voir détails",
                                    style:
                                        GoogleFonts.lato(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  height: 50,
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 8.0,
          right: 15.0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.red[900].withOpacity(.8),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 10.0,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              children: [
                Center(
                  child: Text(
                    '${product.prix} ${product.devise}',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
