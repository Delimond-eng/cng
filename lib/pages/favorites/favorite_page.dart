import 'package:cng/components/custom_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../index.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return PageComponent(
      child: Column(
        children: [
          buildHeader(),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Lottie.asset("assets/lotties/629-empty-box.json"),
              ),
            ),
          )
        ],
      ),
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
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/delivery-svgrepo-com.svg",
                      color: Colors.yellow[800],
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  "Mes achats",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
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
    );
  }
}
