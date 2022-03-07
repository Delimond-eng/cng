import 'dart:convert';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cng/components/global_header.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../index.dart';
import 'offer_view_page.dart';

class UserProductViewPage extends StatefulWidget {
  const UserProductViewPage({Key key}) : super(key: key);

  @override
  _UserProductViewPageState createState() => _UserProductViewPageState();
}

class _UserProductViewPageState extends State<UserProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageComponent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GlobalHeader(
              icon: CupertinoIcons.back,
              isPageHeader: false,
              title: "Mes Produits & Services",
            ),
            Obx(() {
              return Expanded(
                child: Container(
                  child: managerController.userProducts.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/lotties/629-empty-box.json",
                                  height: 150.0,
                                  width: 150.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Shimmer.fromColors(
                                  child: Text(
                                    "Vous avez aucun produit & service",
                                    style: GoogleFonts.lato(
                                      fontSize: 18.0,
                                      letterSpacing: 1.0,
                                      color: Colors.red[400],
                                    ),
                                  ),
                                  baseColor: Colors.red[400],
                                  highlightColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 2,
                          ),
                          itemCount: managerController.userProducts.length,
                          itemBuilder: (context, index) {
                            var data = managerController.userProducts[index];
                            return UserProductCard(
                              data: data,
                              onPressed: () {
                                if (data.offres.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: OfferViewPage(
                                        produits: data,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget psShimmer(BuildContext context) {
    return Container(
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.0,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/shapes/placeholder.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProductCard extends StatelessWidget {
  const UserProductCard({
    Key key,
    @required this.data,
    this.onPressed,
  }) : super(key: key);

  final Produits data;
  final Function onPressed;

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
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 110.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: primaryColor.withOpacity(.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 12.0,
                          offset: const Offset(0.0, 3.0),
                        )
                      ],
                      image: (data.produitDetails.images.isNotEmpty)
                          ? const DecorationImage(
                              image:
                                  AssetImage("assets/shapes/placeholder.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              scale: 1.5,
                            )
                          : const DecorationImage(
                              image:
                                  AssetImage("assets/shapes/placeholder.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.trash_fill,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.titre,
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
                      child: Text(
                        '${data.prix} ${data.devise}',
                        style: GoogleFonts.lato(
                          color: Colors.yellow[900],
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 5.0,
            bottom: 5.0,
            child: FlatButton(
              padding: const EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: accentColor,
              child: Row(
                children: [
                  const Text(
                    "Voir offres  ",
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text("${data.offres.length}")),
                  )
                ],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
/**/

/*
MemoryImage(
                                base64Decode(data
                                    .produitDetails
                                    .images[Random().nextInt(
                                        data.produitDetails.images.length)]
                                    .media),
                              )
*/
