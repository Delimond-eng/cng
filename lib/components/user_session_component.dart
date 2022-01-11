import 'dart:io';

import 'package:cng/constants/global.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../index.dart';

class UserSession extends StatelessWidget {
  final usersession = storage.read("userid");
  final username = storage.read("username");
  @override
  Widget build(BuildContext context) {
    return (usersession != null)
        ? PopupMenuButton(
            color: const Color(0xff000033),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                topRight: Radius.zero,
                topLeft: Radius.circular(20.0),
              ),
            ),
            elevation: 10,
            child: Container(
              height: 40.0,
              width: 40.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green[700].withOpacity(.5),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12.0,
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(0.0, 10.0),
                  )
                ],
              ),
              child: Center(
                child: Icon(CupertinoIcons.person_fill,
                    size: 15.0, color: Colors.grey[200]),
              ),
            ),
            onSelected: (value) {
              switch (value) {
                case 1:
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
                  break;
                case 2:
                  XDialog.show(
                    icon: Icons.help_rounded,
                    context: context,
                    content: "Etes-vous sûr de vouloir fermer l'application ?",
                    title: "Fermeture",
                    onValidate: () {
                      exit(0);
                    },
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 12.0,
                              color: Colors.black.withOpacity(.2),
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.white,
                            size: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        truncateStringWithPoint("$username", 10),
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 19.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: .25,
                        width: double.infinity,
                        color: Colors.cyan,
                      )
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: Icon(
                        Icons.logout_sharp,
                        size: 15,
                        color: Colors.cyan,
                      ),
                    ),
                    Text(
                      'Déconnexion',
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 15.0),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child:
                          const Icon(Icons.close, size: 18, color: Colors.pink),
                    ),
                    Text(
                      "Fermer",
                      style: GoogleFonts.mulish(
                          color: Colors.white, fontSize: 15.0),
                    )
                  ],
                ),
              ),
            ],
          )
        : Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 12.0,
                    color: Colors.black.withOpacity(.2),
                    offset: const Offset(0.0, 10.0))
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
