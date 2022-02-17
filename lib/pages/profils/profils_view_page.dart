import 'dart:math';

import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';
import 'pages/offer_view_page.dart';
import 'pages/user_product_view_page.dart';

class ProfilsViewPage extends StatefulWidget {
  const ProfilsViewPage({Key key}) : super(key: key);

  @override
  _ProfilsViewPageState createState() => _ProfilsViewPageState();
}

class _ProfilsViewPageState extends State<ProfilsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageComponent(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.white.withOpacity(.8),
          Colors.white.withOpacity(.5),
          Colors.transparent,
          Colors.transparent,
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Container(
              child: GridView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                children: [
                  ProfilTile(
                    icon: "assets/icons/bell-notification-svgrepo-com.svg",
                    label: "Notifications",
                    onPressed: () {},
                  ),

                  //${managerController.userProducts.length.toString().padLeft(2, "0")}
                  ProfilTile(
                    badged: false,
                    icon: "assets/icons/shopping-bag-svgrepo-com.svg",
                    label: "Mes produits & services (0)",
                    onPressed: () {
                      /*Navigator.push(
                        context,
                        PageTransition(
                          child: UserProductViewPage(),
                          type: PageTransitionType.rightToLeftWithFade,
                        ),
                      );*/
                    },
                  ),
                  ProfilTile(
                    badged: false,
                    icon: "assets/icons/wallet-svgrepo-com.svg",
                    label: "Ma balance",
                    onPressed: () {},
                  ),
                  ProfilTile(
                    badged: false,
                    icon:
                        "assets/icons/buy-company-merger-acquisition-company-sale-svgrepo-com.svg",
                    label: "Mes achats (0)",
                    onPressed: () {},
                  ),
                  ProfilTile(
                    badged: false,
                    icon: "assets/icons/marketing-svgrepo-com.svg",
                    label: "Mes offres envoyées (0)",
                    onPressed: () {
                      /*Navigator.push(
                        context,
                        PageTransition(
                          child: const OfferViewPage(),
                          type: PageTransitionType.rightToLeftWithFade,
                        ),
                      );*/
                    },
                  ),
                  ProfilTile(
                    badged: false,
                    icon: "assets/icons/help-svgrepo-com.svg",
                    label: "Aide",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
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
                  "Mon compte",
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
    );
  }
}

class ProfilTile extends StatelessWidget {
  final String label, badgeVal;
  final Function onPressed;
  final String icon;
  final bool badged;
  final Color color;
  final Color badgeColor;

  const ProfilTile({
    Key key,
    this.label,
    this.onPressed,
    this.icon,
    this.badged = false,
    this.color,
    this.badgeVal,
    this.badgeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: AssetImage("assets/shapes/shapebg.jpg"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 3),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white.withOpacity(.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 3),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)]
                          .shade900,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.1),
                          offset: const Offset(0, 3),
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Flexible(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
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
}
