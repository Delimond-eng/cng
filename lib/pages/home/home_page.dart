// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/widgets/category_card.dart';
import 'package:cng/widgets/promo_product_card.dart';
import 'package:cng/widgets/search_bar_widget.dart';
import 'package:cng/widgets/trade_little_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../index.dart';
import 'pages/catalog_page.dart';
import 'pages/trading_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGridView = true;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/shapes/shapebg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.5),
                Colors.white.withOpacity(.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Obx(
              () => Column(
                children: [
                  buildHeader(),
                  Expanded(
                    child: Container(
                      child: Scrollbar(
                        controller: scrollController,
                        radius: const Radius.circular(5.0),
                        thickness: 2.0,
                        child: ListView(
                          controller: scrollController,
                          children: [
                            categoriesSection(context),
                            if (managerController.homeProducts.isEmpty) ...[
                              titleShimmer(context),
                            ] else ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 17.0,
                                  right: 17.0,
                                  top: 17.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Produits recommandés",
                                      style: GoogleFonts.lato(
                                        color: primaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ViewMoreBtn(
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ),
                            ],
                            buildRecommanderList(context),
                            if (managerController.homeProducts.isEmpty) ...[
                              titleShimmer(context),
                            ] else ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 17.0,
                                  right: 17.0,
                                  top: 17.0,
                                  bottom: 17.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Produits & services en vente",
                                      style: GoogleFonts.lato(
                                        color: primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue,
                                            primaryColor,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.3),
                                            blurRadius: 12.0,
                                            offset: const Offset(0, 3),
                                          )
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          onTap: () {
                                            setState(() {
                                              isGridView = !isGridView;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  isGridView
                                                      ? Icons.list
                                                      : Icons.grid_view,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 10.0),
                                                Text(
                                                  isGridView ? "Liste" : "Grid",
                                                  style: GoogleFonts.lato(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                            if (managerController.homeProducts.isEmpty) ...[
                              Shimmer.fromColors(
                                baseColor: primaryColor.withOpacity(.2),
                                highlightColor: Colors.white,
                                enabled: true,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: .95,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(.2),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.1),
                                            blurRadius: 12.0,
                                            offset: const Offset(0.0, 10.0),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ] else ...[
                              if (isGridView) ...[
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      managerController.homeProducts.length,
                                  itemBuilder: (context, index) {
                                    var data =
                                        managerController.homeProducts[index];
                                    return ProductTradeLittleCard(
                                      product: data,
                                      onPressed: () async {
                                        Xloading.showLoading(context);
                                        var result = await managerController
                                            .getSingleProduct(
                                                produitId: data.produitId);
                                        if (result != null) {
                                          Xloading.dismiss();
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: TradingPage(
                                                product: data,
                                                produitDetails: result
                                                    .singleData.produitDetails,
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                            ),
                                          );
                                        } else {
                                          Xloading.dismiss();
                                        }
                                      },
                                    );
                                  },
                                )
                              ] else ...[
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      managerController.homeProducts.length,
                                  itemBuilder: (context, index) {
                                    var data =
                                        managerController.homeProducts[index];
                                    return ProductTradeListCard(
                                      product: data,
                                      onPressed: () async {
                                        Xloading.showLoading(context);

                                        var result = await managerController
                                            .getSingleProduct(
                                                produitId: data.produitId);
                                        if (result != null) {
                                          Xloading.dismiss();
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              child: TradingPage(
                                                product: data,
                                                produitDetails: result
                                                    .singleData.produitDetails,
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                            ),
                                          );
                                        } else {
                                          Xloading.dismiss();
                                        }
                                      },
                                    );
                                  },
                                )
                              ]
                            ]
                          ],
                        ),
                      ),
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

  Shimmer titleShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: primaryColor.withOpacity(.2),
      highlightColor: Colors.white,
      enabled: true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 10.0),
        height: 20.0,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  Widget buildRecommanderList(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: MediaQuery.of(context).size.height * .35,
      child: managerController.homeProducts.isEmpty
          ? ListView.builder(
              itemCount: 4,
              padding: const EdgeInsets.only(left: 20, bottom: 10.0, top: 10.0),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return rcShimmer(context);
              },
            )
          : ListView.builder(
              itemCount: managerController.homeProducts.length,
              padding: const EdgeInsets.only(left: 20, bottom: 10.0, top: 10.0),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = managerController.homeProducts[index];
                return PromoProductCard(
                  product: data,
                  onPressed: () async {
                    Xloading.showLoading(context);
                    var result = await managerController.getSingleProduct(
                        produitId: data.produitId);
                    if (result != null) {
                      Xloading.dismiss();
                      Navigator.push(
                        context,
                        PageTransition(
                          child: TradingPage(
                            product: data,
                            produitDetails: result.singleData.produitDetails,
                          ),
                          type: PageTransitionType.rightToLeftWithFade,
                        ),
                      );
                    } else {
                      Xloading.dismiss();
                    }
                  },
                );
              },
            ),
    );
  }

  Widget rcShimmer(BuildContext context) {
    return Shimmer(
      enabled: true,
      direction: ShimmerDirection.ltr,
      gradient: LinearGradient(
        colors: [
          primaryColor.withOpacity(.1),
          Colors.white.withOpacity(.7),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        height: 200.0,
        width: MediaQuery.of(context).size.width / 1.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: primaryColor,
            width: .5,
          ),
          color: Colors.grey.withOpacity(.5),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return CustomHeader(
      hasColored: true,
      color: Colors.white.withOpacity(.5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Container(
                height: 50.0,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Row(
                        children: [
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/icons/app_icon.png"),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.yellow[800],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Wenze ',
                                  style: GoogleFonts.lato(
                                    color: Colors.yellow[800],
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Teka Somba',
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    letterSpacing: 1.0,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: UserSession(),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 10.0,
              ),
              child: SearchBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriesSection(BuildContext context) {
    if (managerController.homeCategories.isEmpty) {
      return Shimmer.fromColors(
        enabled: true,
        direction: ShimmerDirection.ltr,
        baseColor: primaryColor.withOpacity(.4),
        highlightColor: Colors.white.withOpacity(.7),
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (_, __) {
            return Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: primaryColor.withOpacity(.3),
                  width: .5,
                ),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1.20,
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
        ),
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: managerController.homeCategories.length,
        itemBuilder: (context, index) {
          var data = managerController.homeCategories[index];
          return CategoryCard(
            data: data,
            onPressed: () async {
              if (data.sousCategories != null &&
                  data.sousCategories.isNotEmpty) {
                Xloading.showLoading(context);
                await managerController.viewProductByCategorie(
                    id: data.produitCategorieId);
                Xloading.dismiss();

                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: CatalogPage(
                        selectedCategory: data,
                        subCategries: data.sousCategories),
                  ),
                );
              }
            },
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.20,
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
      );
    }
  }
}

class ViewMoreBtn extends StatelessWidget {
  final Function onPressed;
  const ViewMoreBtn({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            Colors.blue,
          ],
        ),
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_right_alt_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 5.0),
                Text(
                  "Voir plus",
                  style: GoogleFonts.lato(
                    color: Colors.white,
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

class MenuBtn extends StatelessWidget {
  final Function onPressed;
  const MenuBtn({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12.0,
            offset: const Offset(0.0, 10.0),
          )
        ],
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 40.0,
            width: 40.0,
            child: SvgPicture.asset(
              "assets/icons/menu-2-svgrepo-com.svg",
              fit: BoxFit.cover,
              color: Colors.blue[900],
              height: 30.0,
              width: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
