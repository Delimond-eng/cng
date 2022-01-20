// ignore_for_file: avoid_unnecessary_containers

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/models/products_model.dart';
import 'package:cng/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isGridView = true;
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
            child: Column(
              children: [
                buildHeader(),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [
                        categoriesSection(),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 17.0,
                            right: 17.0,
                            top: 17.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Produits recommandés",
                                style: GoogleFonts.lato(
                                  color: primaryColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.yellow[800].withOpacity(.7),
                                  borderRadius: BorderRadius.circular(20.0),
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
                                  child: InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.view_array_rounded,
                                            size: 18,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text("Voir plus")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .35,
                          child: FutureBuilder<ProductsModel>(
                            future: ApiManager.viewHomeDatas(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return ListView.builder(
                                  itemCount: 4,
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10.0, top: 10.0),
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return rcShimmer(context);
                                  },
                                );
                              } else {
                                return ListView.builder(
                                  itemCount:
                                      snapshot.data.reponse.produits.length,
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10.0, top: 10.0),
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var data =
                                        snapshot.data.reponse.produits[index];
                                    return PromoProductCard(
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
                                );
                              }
                            },
                          ),
                        ),
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
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                width: 90.0,
                                decoration: BoxDecoration(
                                  color: Colors.yellow[800].withOpacity(.7),
                                  borderRadius: BorderRadius.circular(20.0),
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
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isGridView = !isGridView;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isGridView
                                                ? Icons.list
                                                : Icons.grid_view,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 10.0),
                                          Text(isGridView ? "Liste" : "Grid")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        FutureBuilder<ProductsModel>(
                          future: ApiManager.viewHomeDatas(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
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
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Shimmer(
                                    enabled: true,
                                    direction: ShimmerDirection.ttb,
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryColor.withOpacity(.1),
                                        Colors.white.withOpacity(.7),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    child: psShimmer(context),
                                  );
                                },
                              );
                            } else {
                              return (isGridView)
                                  ? GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                          snapshot.data.reponse.produits.length,
                                      itemBuilder: (context, index) {
                                        var data = snapshot
                                            .data.reponse.produits[index];
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
                                          snapshot.data.reponse.produits.length,
                                      itemBuilder: (context, index) {
                                        var data = snapshot
                                            .data.reponse.produits[index];
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
                                    );
                            }
                          },
                        )
                      ],
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

  Widget psShimmer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
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

  Widget buildBanner(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Swiper(
        autoplay: true,
        autoplayDelay: 10000,
        viewportFraction: 0.95,
        itemBuilder: (BuildContext context, int index) {
          var data = slides[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(data.imagePath),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withOpacity(.4),
                    Colors.yellow[800].withOpacity(.4)
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 15.0,
                    right: 10.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(0, 12),
                          )
                        ],
                      ),
                      height: 60.0,
                      width: 150.0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.title,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: slides.length,
        pagination: const SwiperPagination(),
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

  Widget categoriesSection() {
    return FutureBuilder<MenuConfigModel>(
      future: ApiManager.viewCategories(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Shimmer.fromColors(
            enabled: true,
            direction: ShimmerDirection.ltr,
            baseColor: Colors.grey[300].withOpacity(.5),
            highlightColor: Colors.white.withOpacity(.7),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: Row(
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    Container(
                      width: 100.0,
                      height: 80.0,
                      margin: const EdgeInsets.only(left: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < snapshot.data.config.length; i++) ...[
                  CategoryCard(
                    data: snapshot.data.config[i],
                    onPressed: () {
                      if (snapshot.data.config[i].sousCategories.isNotEmpty) {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRightWithFade,
                            child: CatalogPage(
                                subCategries:
                                    snapshot.data.config[i].sousCategories),
                          ),
                        );
                      }
                    },
                  )
                ]
              ],
            ),
          );
        }
      },
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

List<Product> products = [
  Product(
    image: "assets/images/voiture.jpg",
    label: "Hundai Clio",
    price: 2500.0,
    last: 3000.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/bag2.jpg",
    label: "Woman's bag",
    price: 30.0,
    last: 55.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/shoes.jpg",
    label: "Man shoes",
    price: 25.0,
    last: 50.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/voiture1.jpeg",
    label: "Citroen",
    price: 3500.0,
    last: 4800.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/pc.jpeg",
    label: "LapTop core i7",
    price: 450.0,
    last: 550.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/mobi-s.jpg",
    label: "Samsung S21 Ultra",
    price: 350.0,
    last: 450.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/mobile-i.jpeg",
    label: "Iphone 13",
    price: 600.0,
    last: 800.0,
    currency: "\$",
  ),
  Product(
    image: "assets/images/bag.jpg",
    label: "Woman bag vip",
    price: 150.0,
    last: 250.0,
    currency: "\$",
  ),
];

List<Category> categories = [
  Category(label: "Vehicule", icon: "assets/icons/car-svgrepo-com.svg"),
  Category(
    label: "Maison",
    icon: "assets/icons/house-svgrepo-com.svg",
  ),
  Category(
    label: "Fourniture de maison",
    icon:
        "assets/icons/furniture-home-furniture-design-interior-svgrepo-com.svg",
  ),
  Category(
    label: "Sport, art & autres",
    icon: "assets/icons/sport-svgrepo-com.svg",
  ),
  Category(
    label: "Mobile phone & tablette",
    icon: "assets/icons/mobile-svgrepo-com.svg",
  ),
];

List<Slide> slides = [
  Slide(
      imagePath: "assets/images/buy.jpg",
      title: "Acheter et vendre vos produits !"),
  Slide(imagePath: "assets/images/service.jpg", title: "Emploi et service !"),
  Slide(imagePath: "assets/images/buy2.jpg", title: "CNG Acheter & Vendre !"),
];

class Slide {
  String imagePath;
  String title;
  Slide({
    this.imagePath,
    this.title,
  });
}

class Product {
  String label, image, currency;
  double price, last;

  Product({this.image, this.price, this.last, this.label, this.currency});
}

class Category {
  String label, icon;
  Category({this.label, this.icon});
}
