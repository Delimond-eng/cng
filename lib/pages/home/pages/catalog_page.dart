import 'package:cng/components/custom_header.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/widgets/product_trade_card_widget.dart';
import 'package:cng/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../../index.dart';
import '../index.dart';
import 'trading_page.dart';

class CatalogPage extends StatefulWidget {
  final List<SousCategories> subCategries;
  CatalogPage({Key key, this.subCategries}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
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
            child: Column(
              children: [
                buildHeader(),
                Expanded(
                  child: Container(
                    child: Scrollbar(
                      radius: const Radius.circular(10.0),
                      thickness: 3.0,
                      child: GridView.builder(
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
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductTradeCard(
                            product: products[index],
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: TradingPage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
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
                      "Catalogue des produits",
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 12.0,
                          color: Colors.black.withOpacity(.2),
                          offset: const Offset(0.0, 10.0))
                    ],
                  ),
                  child: Center(
                    child: Icon(CupertinoIcons.person,
                        size: 15.0, color: Colors.grey[200]),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: const SearchBar(),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 70,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.subCategries.length,
              itemBuilder: (context, index) {
                var data = widget.subCategries[index];
                return Container(
                  height: 60,
                  margin: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/shapes/shapebg.png"),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        blurRadius: 10.0,
                        offset: const Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(.8),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  shape: BoxShape.circle,
                                ),
                                child: data.sousCategorieIcon.isNotEmpty
                                    ? SvgPicture.network(
                                        data.sousCategorieIcon,
                                        color: Colors.grey[100],
                                        height: 30.0,
                                        width: 30.0,
                                      )
                                    : SvgPicture.asset(
                                        "assets/icons/category-svgrepo-com.svg",
                                        color: Colors.grey[100],
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                data.sousCategorie,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0,
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
            ),
          ),
        ],
      ),
    );
  }
}
