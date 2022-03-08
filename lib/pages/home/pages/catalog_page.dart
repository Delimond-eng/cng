import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/pages/home/pages/trading_page.dart';
import 'package:cng/widgets/search_bar_widget.dart';
import 'package:cng/widgets/trade_little_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../index.dart';

class CatalogPage extends StatefulWidget {
  final List<SousCategories> subCategries;
  final Config selectedCategory;
  const CatalogPage({Key key, this.subCategries, this.selectedCategory})
      : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool isGridView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Obx(() {
              return Column(
                children: [
                  buildHeader(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 17.0,
                      bottom: 17.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Produits & services en vente",
                          style: GoogleFonts.lato(
                            color: primaryColor,
                            fontSize: 18.0,
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
                              onTap: () {
                                setState(() {
                                  isGridView = !isGridView;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isGridView ? Icons.list : Icons.grid_view,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      isGridView ? "Liste" : "Grid",
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
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
                  Expanded(
                    child: managerController.products.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    "assets/lotties/93134-not-found.json",
                                    height: 180.0,
                                    width: 180.0,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            child: (isGridView)
                                ? GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15.0),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      crossAxisCount: 2,
                                    ),
                                    itemCount:
                                        managerController.products.length,
                                    itemBuilder: (context, index) {
                                      var data =
                                          managerController.products[index];
                                      return ProductTradeLittleCard(
                                        product: data,
                                        onPressed: () async {
                                          Xloading.showLoading(context);
                                          await managerController
                                              .getSingleProduct(
                                                  produitId: data.produitId);
                                          Xloading.dismiss();
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              child: TradingPage(
                                                product: data,
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        managerController.products.length,
                                    itemBuilder: (context, index) {
                                      var data =
                                          managerController.products[index];
                                      return ProductTradeListCard(
                                        product: data,
                                        onPressed: () async {
                                          Xloading.showLoading(context);
                                          await managerController
                                              .getSingleProduct(
                                                  produitId: data.produitId);
                                          Xloading.dismiss();
                                          await Navigator.push(
                                            context,
                                            PageTransition(
                                              child: TradingPage(
                                                product: data,
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                          ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return CustomHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.8),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.back,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      widget.selectedCategory.categorie,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                UserSession()
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: SearchBar(),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 5.0),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.subCategries
                  .map((data) => SubCategoryCard(data: data))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final SousCategories data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 8.0,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: () async {
            Xloading.showLoading(context);
            await managerController
                .viewProductBySubCategorie(id: data.produitSousCategorieId)
                .then((_) {
              Xloading.dismiss();
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 8.0, 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: (data.sousCategorieIcon != null &&
                          data.sousCategorieIcon.isNotEmpty)
                      ? SvgPicture.network(
                          data.sousCategorieIcon,
                          color: Colors.grey[100],
                          height: 15.0,
                          width: 15.0,
                        )
                      : SvgPicture.asset(
                          "assets/icons/category-svgrepo-com.svg",
                          color: Colors.grey[100],
                          height: 15.0,
                          width: 15.0,
                        ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  data.sousCategorie,
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
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
