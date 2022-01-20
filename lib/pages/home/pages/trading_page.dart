import 'dart:convert';

import 'package:cng/components/custom_header.dart';
import 'package:cng/components/photo_view.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/constants/controllers.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat.dart';
import 'package:cng/models/products_model.dart';
import 'package:cng/models/single_product_model.dart';
import 'package:cng/pages/messages/pages/chat_details_page.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:cng/services/api_manager.dart';
import 'package:cng/utils/dialog.dart';
import 'package:cng/widgets/trade_little_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class TradingPage extends StatefulWidget {
  final Product product;
  TradingPage({Key key, this.product}) : super(key: key);

  @override
  _TradingPageState createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  final PageController pageController = PageController(initialPage: 0);
  final ValueNotifier<int> sliderNotifier = ValueNotifier(0);

  final _formOffreKey = GlobalKey<FormState>();
  final _textOffreMontant = TextEditingController();
  bool isGridView = true;
  final textMessage = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Future<void> sendOffer(context) async {
    var userId = storage.read("userid");
    if (userId == null) {
      Navigator.push(
        context,
        PageTransition(
          child: AuthLogin(),
          type: PageTransitionType.bottomToTop,
        ),
      );
      return;
    }
    Modal.show(
      context,
      height: 230.0,
      title: "Envoi d'offre",
      modalContent: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Form(
          key: _formOffreKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Insérez le montant pour faire une offre !",
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _textOffreMontant,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le montant de votre offre est réquis !";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Montant d'offre",
                          hintText: 'Entrez le montant...',
                          prefixIcon: Icon(
                            CupertinoIcons.money_dollar_circle_fill,
                            color: Colors.yellow[900],
                            size: 16.0,
                          ),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black54, width: 1.0),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      color: Colors.grey[500],
                      child: Center(
                        child: Text(
                          widget.product.devise,
                          style: GoogleFonts.lato(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  height: 50.0,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.green[700],
                    elevation: 10.0,
                    onPressed: () async {
                      if (_formOffreKey.currentState.validate()) {
                        Xloading.showLoading(context);

                        await managerController
                            .envoyerOffre(
                          context,
                          montant: _textOffreMontant.text,
                          produitId: widget.product.produitId,
                        )
                            .then((res) async {
                          if (res != null) {
                            Xloading.dismiss();
                            XDialog.showSuccessAnimation(context);
                            Future.delayed(
                              const Duration(milliseconds: 1000),
                              () {
                                Get.back();
                                _textOffreMontant.text = "";
                              },
                            );
                          } else {
                            Xloading.dismiss();
                          }
                        });
                      }
                    },
                    child: Text(
                      "Valider",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
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

  Future<void> sendMessage(context) async {
    var userId = storage.read("userid");
    if (userId == null) {
      Navigator.push(
        context,
        PageTransition(
          child: AuthLogin(),
          type: PageTransitionType.bottomToTop,
        ),
      );
      return;
    }
    if (textMessage.text.isEmpty) {
      Get.snackbar(
        "Avertissement",
        "vous devez taper votre message !",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black87,
        maxWidth: MediaQuery.of(context).size.width - 2,
        borderRadius: 10,
        duration: const Duration(seconds: 5),
      );
      return;
    }
    Chat chat = Chat(
      produitId: widget.product.produitId,
      message: textMessage.text,
      userId: storage.read("userid"),
    );
    //hide keyboard
    FocusScope.of(context).unfocus();
    Xloading.showLoading(context);
    await ApiManager.chatService(chat: chat).then((res) {
      Xloading.dismiss();
      print(res);
      setState(() {
        textMessage.text = "";
      });

      if (res["reponse"]["status"] == "success") {
        String chatId = res['reponse']['chat_id'].toString();
        chatController.messages.clear();
        Navigator.push(
          context,
          PageTransition(
            child: ChatDetailsPage(
              messageSender: "Nouvelle discussion",
              produitId: widget.product.produitId,
              chatId: chatId,
            ),
            type: PageTransitionType.rightToLeftWithFade,
          ),
        );
      } else {
        Get.snackbar(
          "Info",
          "Cette discussion est en cours... !",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.blue,
          maxWidth: MediaQuery.of(context).size.width - 2,
          borderRadius: 10,
          duration: const Duration(seconds: 5),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: sliderNotifier,
        builder: (context, slide, __) {
          return Container(
            height: size.height,
            width: size.width,
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
                  () {
                    return Column(
                      children: [
                        headerStack(),
                        /**/
                        const SizedBox(
                          height: 65.0,
                        ),
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(
                                top: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (managerController.singleProduct.value
                                      .produitDetails.images.isNotEmpty)
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 5.0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: managerController
                                            .singleProduct
                                            .value
                                            .produitDetails
                                            .images
                                            .length,
                                        itemBuilder: (context, index) {
                                          var data = managerController
                                              .singleProduct
                                              .value
                                              .produitDetails
                                              .images[index];
                                          return Container(
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                                left: 8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: slide == index
                                                  ? Border.all(
                                                      color: Colors.yellow[800],
                                                      width: 1.0,
                                                    )
                                                  : null,
                                              image: DecorationImage(
                                                image: MemoryImage(
                                                  base64Decode(data.media),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(.2),
                                                  blurRadius: 10.0,
                                                  offset: const Offset(0, 5),
                                                )
                                              ],
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.zero,
                                              child: InkWell(
                                                borderRadius: BorderRadius.zero,
                                                onTap: () {
                                                  sliderNotifier.value = index;
                                                  pageController.animateToPage(
                                                    sliderNotifier.value,
                                                    curve: Curves.bounceInOut,
                                                    duration: const Duration(
                                                      milliseconds: 500,
                                                    ),
                                                  );
                                                },
                                                child: Container(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                  const SizedBox(height: 10.0),
                                  if (managerController.singleProduct.value
                                      .produitDetails.details.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          bottom: 17.0),
                                      child: Text(
                                        "Détails",
                                        style: GoogleFonts.lato(
                                          color: Colors.black87,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                  if (managerController.singleProduct.value
                                      .produitDetails.details.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var data = managerController
                                            .singleProduct
                                            .value
                                            .produitDetails
                                            .details[index];
                                        return DetailCard(
                                          data: data,
                                        );
                                      },
                                      itemCount: managerController.singleProduct
                                          .value.produitDetails.details.length,
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 15.0,
                                      left: 10.0,
                                      right: 10.0,
                                      top: 15.0,
                                    ),
                                    child: OutLinedBtn(
                                      label: "Envoyer une offre",
                                      onPressed: () => sendOffer(context),
                                    ),
                                  ),
                                  //Start chat section
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Center(
                                                child: Text(
                                                  "Appelez moi",
                                                  style: GoogleFonts.lato(
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Center(
                                                child: Text(
                                                  "Le produit est-il toujours disponible ?",
                                                  style: GoogleFonts.lato(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        TextField(
                                          controller: textMessage,
                                          decoration: InputDecoration(
                                            labelText: "Message",
                                            hintText: 'Entrez votre message...',
                                            prefixIcon: Icon(
                                              CupertinoIcons.chat_bubble_text,
                                              color: Colors.yellow[900],
                                              size: 16.0,
                                            ),
                                            fillColor: Colors.white,
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black54,
                                                  width: 1.0),
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black54,
                                                  width: 1.0),
                                              borderRadius: BorderRadius.zero,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: primaryColor,
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.zero,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        Container(
                                          height: 60.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // ignore: deprecated_member_use
                                          child: RaisedButton.icon(
                                            color: Colors.yellow[800],
                                            elevation: 0,
                                            icon: const Icon(Icons.send_rounded,
                                                color: Colors.white),
                                            label: Text(
                                              "Commencer une discussion",
                                              style: GoogleFonts.lato(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () =>
                                                sendMessage(context),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  buildFournisseurInfos(),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            height: 40.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // ignore: deprecated_member_use
                                            child: RaisedButton.icon(
                                              color: Colors.green[700],
                                              icon: const Icon(
                                                  Icons.wifi_calling_3,
                                                  color: Colors.white),
                                              label: Text(
                                                "voir contact",
                                                style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                XDialog.showCustomDialog(
                                                    context);
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Flexible(
                                          child: Container(
                                            height: 40.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // ignore: deprecated_member_use
                                            child: RaisedButton.icon(
                                              color: primaryColor,
                                              icon: const Icon(
                                                CupertinoIcons.chat_bubble_text,
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                "Discussion",
                                                style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        )
                                      ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Produits similaires",
                                          style: GoogleFonts.lato(
                                            color: primaryColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.yellow[800]
                                                .withOpacity(.7),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(.3),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      isGridView
                                                          ? Icons.list
                                                          : Icons.grid_view,
                                                      size: 15,
                                                    ),
                                                    const SizedBox(width: 5.0),
                                                    Text(isGridView
                                                        ? "Liste"
                                                        : "Grid")
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
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Shimmer(
                                              enabled: true,
                                              direction: ShimmerDirection.ttb,
                                              gradient: LinearGradient(
                                                colors: [
                                                  primaryColor.withOpacity(.1),
                                                  Colors.white.withOpacity(.8),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 15.0),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 0.8,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  crossAxisCount: 2,
                                                ),
                                                itemCount: snapshot.data.reponse
                                                    .produits.length,
                                                itemBuilder: (context, index) {
                                                  var data = snapshot.data
                                                      .reponse.produits[index];
                                                  return ProductTradeLittleCard(
                                                    product: data,
                                                    onPressed: () async {
                                                      /*Xloading.showLoading(
                                                          context);
                                                      await managerController
                                                          .getSingleProduct(
                                                              produitId: data
                                                                  .produitId);
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
                                                      );*/
                                                    },
                                                  );
                                                },
                                              )
                                            : ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.reponse
                                                    .produits.length,
                                                itemBuilder: (context, index) {
                                                  var data = snapshot.data
                                                      .reponse.produits[index];
                                                  return ProductTradeListCard(
                                                    product: data,
                                                    onPressed: () async {
                                                      /*Xloading.showLoading(
                                                          context);
                                                      await managerController
                                                          .getSingleProduct(
                                                              produitId: data
                                                                  .produitId);
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
                                                      );*/
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
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
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

  Widget buildFournisseurInfos() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Row(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(.7),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    managerController
                        .singleProduct.value.produitDetails.user.nom
                        .substring(0, 1)
                        .toUpperCase(),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                managerController.singleProduct.value.produitDetails.user.nom,
                style: GoogleFonts.lato(
                  color: primaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 17.0,
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              RatingBar.builder(
                wrapAlignment: WrapAlignment.center,
                initialRating: managerController
                    .singleProduct.value.produitDetails.user.cote
                    .toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                itemSize: 10.0,
                allowHalfRating: false,
                ignoreGestures: true,
                unratedColor: Colors.transparent,
                itemCount: 3,
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.orange.withOpacity(.7),
                ),
                updateOnDrag: false,
                onRatingUpdate: (double value) {},
              ),
              const SizedBox(
                height: 4.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.mail,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        managerController
                            .singleProduct.value.produitDetails.user.email,
                        style: GoogleFonts.lato(
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.phone,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        managerController
                            .singleProduct.value.produitDetails.user.telephone,
                        style: GoogleFonts.lato(
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /*Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.yellow[900],
                      size: 15.0,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "RD Congo, kinshasa",
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )*/
            ],
          )
        ],
      ),
    );
  }

  Widget headerStack() {
    return StatefulBuilder(
      builder: (context, setter) {
        return Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage("assets/shapes/shapeheader.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(.8),
                      primaryColor.withOpacity(.8),
                      Colors.white.withOpacity(.7)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -MediaQuery.of(context).size.height * 0.10,
              left: 10.0,
              right: 10.0,
              child: Stack(
                children: [
                  if (managerController
                      .singleProduct.value.produitDetails.images.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.zero,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(0.0, 10.0),
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: managerController
                            .singleProduct.value.produitDetails.images.length,
                        onPageChanged: (value) {
                          sliderNotifier.value = value;
                        },
                        itemBuilder: (context, index) {
                          var image = managerController
                              .singleProduct.value.produitDetails.images[index];
                          return Container(
                            height: MediaQuery.of(context).size.height * .28,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: image.media.isNotEmpty
                                  ? DecorationImage(
                                      image: MemoryImage(
                                          base64Decode(image.media)),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage(
                                          "assets/shapes/placeholder.png"),
                                      fit: BoxFit.fill,
                                    ),
                              color: Colors.white,
                              borderRadius: BorderRadius.zero,
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
                              child: InkWell(
                                onTap: () {
                                  if (image.media.length > 200) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PhotoViewer(
                                          tag: image.produitMediaId,
                                          image: image.media,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/shapes/placeholder.png"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.zero,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black.withOpacity(.2),
                            offset: const Offset(0.0, 10.0),
                          )
                        ],
                      ),
                    ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration:
                          BoxDecoration(color: primaryColor.withOpacity(.4)),
                      child: Center(
                        child: Text(
                          widget.product.titre,
                          style: GoogleFonts.lato(
                              color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 60,
                    bottom: 60,
                    child: SlideBtn(
                        icon: CupertinoIcons.chevron_left,
                        onSlided: () {
                          if (sliderNotifier.value <= 0) {
                            return;
                          }
                          setter(() {
                            sliderNotifier.value--;
                          });
                          pageController.animateToPage(sliderNotifier.value,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.bounceInOut);
                        }),
                  ),
                  Positioned(
                    right: 0,
                    top: 60,
                    bottom: 60,
                    child: SlideBtn(
                      icon: CupertinoIcons.chevron_right,
                      onSlided: () {
                        if (sliderNotifier.value ==
                            managerController.singleProduct.value.produitDetails
                                    .images.length -
                                1) {
                          return;
                        }
                        setter(() {
                          sliderNotifier.value++;
                        });
                        pageController.animateToPage(sliderNotifier.value,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceInOut);
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10.0,
              left: 15.0,
              right: 15.0,
              child: buildHeader(),
            ),
          ],
        );
      },
    );
  }

  Widget buildHeader() {
    return CustomHeader(
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
                    color: Colors.white.withOpacity(.5),
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
                "Achat de produit",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              )
            ],
          ),
          UserSession()
        ],
      ),
    );
  }
}

class SlideBtn extends StatelessWidget {
  final Function onSlided;
  final IconData icon;
  const SlideBtn({
    Key key,
    this.onSlided,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      height: 70.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.black26,
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSlided,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final Details data;
  const DetailCard({
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.yellow[800],
            width: 1.0,
          ),
          right: BorderSide(
            color: Colors.yellow[800],
            width: 1.0,
          ),
        ),
        color: Colors.white.withOpacity(.7),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 10.0,
              offset: const Offset(0, 5.0))
        ],
      ),
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data.sousCategorieDetail,
                  style: GoogleFonts.lato(
                    color: primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data.produitDetail.isEmpty
                      ? "vide !"
                      : truncateStringWithPoint(data.produitDetail, 15),
                  style: GoogleFonts.lato(
                    color: Colors.black54,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OutLinedBtn extends StatelessWidget {
  final String label;
  final Function onPressed;
  const OutLinedBtn({
    Key key,
    this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.zero,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 12.0,
            offset: const Offset(0.0, 10.0),
          )
        ],
        border: Border.all(
          color: Colors.green[700],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.zero,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.lato(
                  color: Colors.green[700],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
