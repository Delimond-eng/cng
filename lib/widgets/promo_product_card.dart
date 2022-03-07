// ignore_for_file: deprecated_member_use

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
                  color: primaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15.0),
                  image: (product.image != null || product.imageUrl != null)
                      ? DecorationImage(
                          image: product.image != null
                              ? MemoryImage(base64Decode(product.image))
                              : NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                          scale: 2.0,
                          alignment: Alignment.center,
                        )
                      : const DecorationImage(
                          image: AssetImage("assets/shapes/placeholder.png"),
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        primaryColor.withOpacity(.4),
                        primaryColor.withOpacity(.8),
                        primaryColor.withOpacity(.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
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
                          height: 40.0,
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
