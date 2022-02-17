import 'dart:io';

import 'package:cng/constants/global.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:cng/widgets/context_menu_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../index.dart';
import 'package:popover/popover.dart';

class UserSession extends StatelessWidget {
  final usersession = storage.read("userid");
  final username = storage.read("username");

  UserSession({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (usersession != null)
        ? Container(
            height: 40.0,
            width: 40.0,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.black.withOpacity(.2),
                  offset: const Offset(0.0, 10.0),
                )
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {
                  showPopover(
                    barrierColor: Colors.black12,
                    context: context,
                    radius: 20,
                    isParentAlive: () => true,
                    backgroundColor: Colors.black87,
                    bodyBuilder: (context) => const UserSessionMenu(),
                    onPop: () {},
                    direction: PopoverDirection.top,
                    width: MediaQuery.of(context).size.width - 30,
                    height: 160.0,
                    arrowHeight: 10,
                    arrowWidth: 15,
                  );
                },
                child: Center(
                  child: Text(
                    username.toString().substring(0, 1),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12.0,
                  color: Colors.black.withOpacity(.2),
                  offset: const Offset(0.0, 10.0),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: AuthLogin(),
                      type: PageTransitionType.rightToLeftWithFade,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Icon(CupertinoIcons.person,
                        size: 15.0, color: Colors.grey[200]),
                  ),
                ),
              ),
            ),
          );
  }
}

class UserSessionMenu extends StatelessWidget {
  const UserSessionMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView(
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          ContextMenuBtn(
            icon: CupertinoIcons.bell,
            title: "Notifications (0)",
            onPressed: () {},
          ),
          ContextMenuBtn(
            icon: CupertinoIcons.bag_fill,
            title: "Mes produits | services",
            onPressed: () {},
          ),
          ContextMenuBtn(
            icon: CupertinoIcons.shopping_cart,
            title: "Mes achats",
            onPressed: () {},
          ),
          ContextMenuBtn(
            icon: CupertinoIcons.bag,
            title: "Mes offres envoyées (0)",
            onPressed: () {},
          ),
          ContextMenuBtn(
            icon: Icons.logout,
            iconColor: secondaryColor,
            title: "Deconnexion",
            onPressed: () {
              XDialog.show(
                icon: Icons.help_rounded,
                context: context,
                content:
                    "Etes-vous sûr de vouloir vous déconnecter de votre compte ?",
                title: "Déconnexion",
                onValidate: () {
                  storage.remove("userid");
                  storage.remove("username");
                  storage.remove("useremail");
                  storage.remove("telephone");
                  Navigator.push(
                    context,
                    PageTransition(
                      child: AuthLogin(),
                      type: PageTransitionType.leftToRightWithFade,
                    ),
                  );
                },
              );
            },
          ),
          ContextMenuBtn(
            icon: Icons.clear,
            iconColor: Colors.red,
            title: "Fermer",
            onPressed: () {
              XDialog.show(
                icon: Icons.help_rounded,
                context: context,
                content: "Etes-vous sûr de vouloir fermer l'application ?",
                title: "Fermeture",
                onValidate: () {
                  exit(0);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
