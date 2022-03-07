import 'dart:convert';

import 'package:cng/models/products_model.dart';
import 'package:flutter/cupertino.dart';

import '../index.dart';

class ProductTradeLittleCard extends StatelessWidget {
  final Product product;
  final Function onPressed;
  const ProductTradeLittleCard({
    Key key,
    this.product,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: primaryColor.withOpacity(.2),
          width: .5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 12.0,
            offset: const Offset(0.0, 10.0),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.image != null || product.imageUrl != null) ...[
                if (product.image != null && product.image.isNotEmpty) ...[
                  PhysicalModel(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.memory(
                        base64Decode(
                          product.image,
                        ),
                        height: 110.0,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ] else ...[
                  PhysicalModel(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        product.image,
                        height: 110.0,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ]
              ] else ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/shapes/placeholder.png",
                    height: 110.0,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.titre,
                      style: GoogleFonts.lato(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        '${product.prix} ${product.devise}',
                        style: GoogleFonts.lato(
                          color: Colors.yellow[900],
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTradeListCard extends StatelessWidget {
  final Product product;
  final Function onPressed;
  const ProductTradeListCard({
    Key key,
    this.product,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: primaryColor.withOpacity(.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 12.0,
            offset: const Offset(0.0, 10.0),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.image != null || product.imageUrl != null) ...[
                if (product.image != null && product.image.isNotEmpty) ...[
                  PhysicalModel(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.memory(
                        base64Decode(product.image),
                        height: 80.0,
                        width: 100.0,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ] else ...[
                  PhysicalModel(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    elevation: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        product.image,
                        height: 80.0,
                        width: 100.0,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]
              ] else ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    "assets/shapes/placeholder.png",
                    height: 80.0,
                    width: 100.0,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.titre,
                      style: GoogleFonts.lato(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '${product.prix} ${product.devise}',
                        style: GoogleFonts.lato(
                          color: Colors.yellow[900],
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
