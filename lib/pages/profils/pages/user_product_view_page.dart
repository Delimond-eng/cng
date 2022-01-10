import 'package:cng/components/global_header.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:cng/pages/ventes/ventes_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../index.dart';
import 'offer_view_page.dart';

class UserProductViewPage extends StatefulWidget {
  UserProductViewPage({Key key}) : super(key: key);

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
            Expanded(
              child: Container(
                child: StreamBuilder<UserProducts>(
                  stream: managerController.streamUserProducts(),
                  initialData: null,
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SpinKitWave(
                                  color: Colors.yellow[900],
                                  size: 60.0,
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                              child: const Text(
                                'Chargement...',
                              ),
                              baseColor: Colors.black,
                              highlightColor: Colors.white,
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (snapshot.hasData) {
                        if (snapshot.data.produits.isNotEmpty) {
                          return GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: .8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                            itemCount: snapshot.data.produits.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data.produits[index];
                              return ProductCard(
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
                          );
                        } else {
                          Center(
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
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            )
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

/**/

/*

*/
