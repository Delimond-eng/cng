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
        image: const DecorationImage(
          image: AssetImage("assets/shapes/shape2.jpg"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 12.0,
            offset: const Offset(0.0, 10.0),
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.9),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: (product.image != null)
                        ? DecorationImage(
                            image: MemoryImage(base64Decode(product.image)),
                            fit: BoxFit.cover,
                            scale: 1.5,
                          )
                        : const DecorationImage(
                            image: AssetImage("assets/shapes/placeholder.png"),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        height: 8.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20.0)),
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
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
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
        borderRadius: BorderRadius.zero,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.zero,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80.0,
                width: 100,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  image: (product.image != null)
                      ? DecorationImage(
                          image: MemoryImage(base64Decode(product.image)),
                          fit: BoxFit.cover,
                          scale: 1.5,
                        )
                      : const DecorationImage(
                          image: AssetImage("assets/shapes/placeholder.png"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                ),
              ),
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
