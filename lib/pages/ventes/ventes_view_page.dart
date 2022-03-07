import 'dart:convert';

import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:cng/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../index.dart';
import 'pages/add_page.dart';

class VentesViewPage extends StatefulWidget {
  const VentesViewPage({Key key}) : super(key: key);

  @override
  _VentesViewPageState createState() => _VentesViewPageState();
}

class _VentesViewPageState extends State<VentesViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageComponent(
          child: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.red,
                      highlightColor: Colors.red[100],
                      enabled: true,
                      child: Text(
                        "Sélectionnez la catégorie de produit que vous voulez mettre en vente !",
                        style: GoogleFonts.lato(
                          fontSize: 18.0,
                          letterSpacing: .5,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: FutureBuilder<MenuConfigModel>(
                        future: ApiManager.viewCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.7,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 2,
                              ),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return Shimmer(
                                  direction: ShimmerDirection.ltr,
                                  enabled: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor.withOpacity(.3),
                                      primaryColor.withOpacity(.1),
                                    ],
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          blurRadius: 10.0,
                                          offset: const Offset(0, 1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 50.0,
                                            width: 50.0,
                                            padding: const EdgeInsets.all(10.0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "chargement...",
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.7,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 2,
                              ),
                              itemCount: snapshot.data.config.length,
                              itemBuilder: (context, index) {
                                var category = snapshot.data.config[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/shapes/shapebg.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.2),
                                        blurRadius: 10.0,
                                        offset: const Offset(0, 1),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          primaryColor.withOpacity(.9),
                                          primaryColor.withOpacity(.7),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        onTap: () {
                                          var userId = storage.read("userid");
                                          if (userId == null) {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                child: AuthLogin(),
                                                type: PageTransitionType
                                                    .bottomToTop,
                                              ),
                                            );
                                          } else {
                                            if (category.sousCategories !=
                                                    null ||
                                                category.sousCategories
                                                    .isNotEmpty) {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: AddVentePage(
                                                    subCategory:
                                                        category.sousCategories,
                                                  ),
                                                  type: PageTransitionType
                                                      .rightToLeftWithFade,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 50.0,
                                                width: 50.0,
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black12,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: category.categorieIcon !=
                                                        null
                                                    ? SvgPicture.network(
                                                        category.categorieIcon
                                                            .replaceAll("https",
                                                                "http"),
                                                        color: Colors.grey[100],
                                                        height: 50.0,
                                                        width: 50.0,
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/icons/category-svgrepo-com.svg",
                                                        color: Colors.grey[100],
                                                        height: 50.0,
                                                        width: 50.0,
                                                      ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                category.categorie,
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  /**/
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget buildHeader() {
    return CustomHeader(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/app_icon.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  "Vendre produits & services",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
            UserSession()
          ],
        ),
      ),
    );
  }
}

class CostumBtnLight extends StatelessWidget {
  final Function onPressed;
  const CostumBtnLight({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/shapes/shapebg.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 12.0),
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow[800].withOpacity(.8),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.add, size: 18.0),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Poster un produit ou service",
                    style: GoogleFonts.lato(fontSize: 16, letterSpacing: 1.0),
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
