import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';
import 'pages/offer_view_page.dart';
import 'pages/user_product_view_page.dart';

class ProfilsViewPage extends StatefulWidget {
  ProfilsViewPage({Key key}) : super(key: key);

  @override
  _ProfilsViewPageState createState() => _ProfilsViewPageState();
}

class _ProfilsViewPageState extends State<ProfilsViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageComponent(
      child: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Container(
              child: GridView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                children: [
                  ProfilTile(
                    badgeVal: "0",
                    badgeColor: primaryColor,
                    badged: true,
                    icon: CupertinoIcons.bell,
                    label: "Notifications",
                    onPressed: () {},
                  ),
                  ProfilTile(
                    badged: false,
                    icon: CupertinoIcons.cube_box,
                    label:
                        "Mes produits & services (${managerController.userProducts.length.toString().padLeft(2, "0")})",
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: UserProductViewPage(),
                          type: PageTransitionType.rightToLeftWithFade,
                        ),
                      );
                    },
                  ),
                  ProfilTile(
                    badged: false,
                    icon: CupertinoIcons.money_dollar_circle,
                    label: "Ma balance",
                    onPressed: () {},
                  ),
                  ProfilTile(
                    badged: false,
                    icon: CupertinoIcons.cube_box_fill,
                    label: "Mes achats (0)",
                    onPressed: () {},
                  ),
                  ProfilTile(
                    badged: false,
                    icon: CupertinoIcons.bell_circle_fill,
                    label: "Mes offres envoyées (0)",
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const OfferViewPage(),
                          type: PageTransitionType.rightToLeftWithFade,
                        ),
                      );
                    },
                  ),
                  ProfilTile(
                    badged: false,
                    icon: Icons.help_outline_sharp,
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
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/user-profile-svgrepo-com.svg",
                      color: Colors.yellow[800],
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  "Moi",
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
  final IconData icon;
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
        color: (color == null) ? Colors.white : color,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0, 3),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (badged)
                  Badge(
                    badgeColor: badgeColor,
                    badgeContent: Text(
                      badgeVal,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.yellow[800],
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Icon(
                          icon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        color: Colors
                            .primaries[
                                Random().nextInt(Colors.primaries.length)]
                            .shade900,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  child: Text(
                    label,
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
    );
  }
}
