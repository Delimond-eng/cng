import 'dart:convert';

import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:cng/pages/messages/widgets/custom_cache_image.dart';
import 'package:cng/services/api_manager.dart';
import 'package:flutter/cupertino.dart';

import '../../../index.dart';

class OfferViewPage extends StatelessWidget {
  final Produits produits;
  const OfferViewPage({Key key, this.produits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageComponent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomHeader(
              color: primaryColor.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Column(
                  children: [
                    Row(
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
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              "Offres sur ${produits.titre}",
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
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.zero,
                            border: Border.all(color: Colors.yellow[900]),
                            image: produits.produitDetails.images.isNotEmpty
                                ? DecorationImage(
                                    scale: 1.5,
                                    fit: BoxFit.cover,
                                    image: CacheImageProvider(
                                      img: base64Decode(produits
                                          .produitDetails.images[0].media),
                                      tag: produits.produitId,
                                    ),
                                  )
                                : const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/shapes/placeholder.png"),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Votre prix fixé",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "${produits.prix} ${produits.devise}",
                                style: GoogleFonts.lato(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.yellow[900]),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10.0),
                shrinkWrap: true,
                itemCount: produits.offres.length,
                itemBuilder: (context, index) {
                  var data = produits.offres[index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .2,
                    margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          color: Colors.grey.withOpacity(.3),
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 10.0,
                            top: 10.0,
                            left: 10.0,
                          ),
                          width: 120,
                          height: MediaQuery.of(context).size.height * .2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 120,
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          CupertinoIcons.calendar,
                                          size: 15.0,
                                        ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          strDateLongFr(
                                            data.dateEnregistrement
                                                .split("|")[1]
                                                .toString()
                                                .trim(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                      color: primaryColor,
                                      width: .5,
                                    )),
                                  ),
                                  width: 120,
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(CupertinoIcons.time,
                                            size: 15),
                                        const SizedBox(width: 10.0),
                                        Text(
                                          data.dateEnregistrement.split("|")[0],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Montant de l'offre",
                                style: GoogleFonts.lato(color: primaryColor),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "${data.montant} ${produits.devise}",
                                style: GoogleFonts.lato(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  RaisedButton(
                                    elevation: 5.0,
                                    color: Colors.green[700],
                                    child: Text(
                                      "Accepter",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      XDialog.show(
                                        content:
                                            "Etes-vous sûr de vouloir accepter cette offre ?",
                                        context: context,
                                        icon: Icons.help_center,
                                        title: "Offre en attente",
                                        onValidate: () async {
                                          await ApiManager.acceptOrRejectOffer(
                                                  offerId: data.offreId,
                                                  reponse: "accepter")
                                              .then((res) {
                                            if (res != null) {
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                Navigator.pop(context);
                                              });
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  RaisedButton(
                                    elevation: 5.0,
                                    color: Colors.red[400],
                                    child: Text(
                                      "Rejeter",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      XDialog.show(
                                        content:
                                            "Etes-vous sûr de vouloir rejeter cette offre ?",
                                        context: context,
                                        icon: Icons.help_center,
                                        title: "Offre en attente",
                                        onValidate: () async {
                                          await ApiManager.acceptOrRejectOffer(
                                                  offerId: data.offreId,
                                                  reponse: "rejeter")
                                              .then((res) {
                                            if (res != null) {
                                              XDialog.showSuccessAnimation(
                                                  context);
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                Navigator.pop(context);
                                              });
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
