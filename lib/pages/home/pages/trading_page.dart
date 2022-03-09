import 'package:cached_network_image/cached_network_image.dart';
import 'package:cng/components/custom_header.dart';
import 'package:cng/components/photo_view.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/constants/controllers.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat.dart';
import 'package:cng/models/chat_model.dart';
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

class TradingPage extends StatefulWidget {
  final Product product;
  final ProduitDetails produitDetails;
  const TradingPage({Key key, this.product, this.produitDetails})
      : super(key: key);

  @override
  _TradingPageState createState() => _TradingPageState();
}

class _TradingPageState extends State<TradingPage> {
  final PageController pageController = PageController(initialPage: 0);
  final ScrollController scrollController = ScrollController();

  final _formOffreKey = GlobalKey<FormState>();
  final _textOffreMontant = TextEditingController();
  bool isGridView = true;
  Chats lastChat;
  int _selectedImageIndex = 0;

  List<ProductSimulary> products = [];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var userId = storage.read("userid");
    if (userId != null) {
      var data = await ApiManager.viewChats();
      var chatList = data.chats;

      for (var chat in chatList) {
        chat.messages.forEach((e) {
          if (e.produit != null) {
            if (e.produit.produitId == widget.product.produitId) {
              setState(() {
                lastChat = chat;
              });
              return;
            } else {
              print("not found");
            }
          }
        });
      }
    }
    var dataSimularies = await managerController.getSingleProduct(
        produitId: widget.product.produitId);
    if (dataSimularies != null) {
      setState(() {
        products = dataSimularies.singleData.produits;
      });
    }
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

    Chat chat = Chat(
      produitId: widget.product.produitId,
      message: "Bonjour ! Je suis intéressé par ce produit/service !",
      userId: storage.read("userid"),
    );
    //hide keyboard
    FocusScope.of(context).unfocus();
    Xloading.showLoading(context);
    var res = await ApiManager.chatService(chat: chat);
    Xloading.dismiss();
    if (res != null) {
      print(res);
      if (res["reponse"]["status"] == "success") {
        String chatId = res['reponse']['chat_id'].toString();
        chatController.messages.clear();
        Navigator.push(
          context,
          PageTransition(
            child: ChatDetailsPage(
              messageSender: "Nouvelle discussion",
              chatId: chatId,
            ),
            type: PageTransitionType.rightToLeftWithFade,
          ),
        );
      }
    }
  }

  Future<void> viewDiscussion(context) async {
    var userId = storage.read("userid");
    if (userId == null) {
      Navigator.push(
        context,
        PageTransition(
          child: const AuthLogin(),
          type: PageTransitionType.bottomToTop,
        ),
      );
      return;
    }
    chatController.messages.clear();
    Navigator.push(
      context,
      PageTransition(
        child: ChatDetailsPage(
          messageSender:
              lastChat.users.firstWhere((user) => user.userId != userId).nom,
          chatId: lastChat.chatId,
        ),
        type: PageTransitionType.rightToLeftWithFade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
            child: Column(
              children: [
                headerStack(),
                const SizedBox(
                  height: 68,
                ),
                Expanded(
                  child: Container(
                    child: Scrollbar(
                      controller: scrollController,
                      radius: const Radius.circular(8.0),
                      thickness: 5.0,
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        children: [
                          if (widget.produitDetails.images.isNotEmpty)
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.produitDetails.images.length,
                                itemBuilder: (context, index) {
                                  var data =
                                      widget.produitDetails.images[index];
                                  return CachedNetworkImage(
                                    imageUrl: data.mediaUrl,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 100,
                                        margin:
                                            const EdgeInsets.only(left: 8.0),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(.2),
                                          border: _selectedImageIndex == index
                                              ? Border.all(
                                                  color: Colors.yellow[800],
                                                  width: 1.0,
                                                )
                                              : null,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              blurRadius: 10.0,
                                              offset: const Offset(0, 5),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            onTap: () {
                                              setState(() {
                                                _selectedImageIndex = index;
                                              });
                                              pageController.animateToPage(
                                                _selectedImageIndex,
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
                                    placeholder: (context, url) => Container(
                                      width: 100,
                                      margin: const EdgeInsets.only(left: 8.0),
                                      decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(.2),
                                          border: _selectedImageIndex == index
                                              ? Border.all(
                                                  color: Colors.yellow[800],
                                                  width: 1.0,
                                                )
                                              : null,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.2),
                                              blurRadius: 10.0,
                                              offset: const Offset(0, 5),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 100,
                                      margin: const EdgeInsets.only(left: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(.1),
                                        border: _selectedImageIndex == index
                                            ? Border.all(
                                                color: Colors.redAccent,
                                                width: 1.0,
                                              )
                                            : null,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.2),
                                            blurRadius: 10.0,
                                            offset: const Offset(0, 5),
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          const SizedBox(height: 10.0),
                          if (widget.produitDetails.details.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 17.0),
                              child: Text(
                                "Détails",
                                style: GoogleFonts.lato(
                                  color: Colors.black87,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                          if (widget.produitDetails.details.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var data = widget.produitDetails.details[index];
                                return DetailCard(
                                  data: data,
                                );
                              },
                              itemCount: widget.produitDetails.details.length,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Center(
                                        child: Text(
                                          "Appelez moi",
                                          style: GoogleFonts.lato(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                Container(
                                  height: 60.0,
                                  width: MediaQuery.of(context).size.width,
                                  // ignore: deprecated_member_use
                                  child: RaisedButton.icon(
                                    color: Colors.yellow[800],
                                    elevation: 0,
                                    icon: const Icon(Icons.send_rounded,
                                        color: Colors.white),
                                    label: Text(
                                      "Commencer une discussion",
                                      style:
                                          GoogleFonts.lato(color: Colors.white),
                                    ),
                                    onPressed: () => sendMessage(context),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (lastChat != null) ...[
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton.icon(
                                        color: primaryColor,
                                        icon: const Icon(
                                          CupertinoIcons.chat_bubble_text,
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "Voir discussion",
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () =>
                                            viewDiscussion(context),
                                      ),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                          if (products.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width,
                                      // ignore: deprecated_member_use
                                      child: RaisedButton.icon(
                                        color: Colors.pink,
                                        icon: const Icon(Icons.article_rounded,
                                            color: Colors.white),
                                        label: Text(
                                          "voir produits simulaires",
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          viewSimularies(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
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

  Widget simularyProducts() {
    if (isGridView) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return ProductTradeLittleCard(
            product: data,
            onPressed: () async {
              Xloading.showLoading(context);
              await managerController
                  .getSingleProduct(produitId: data.produitId)
                  .then((_) {
                Xloading.dismiss();
              });
            },
          );
        },
      );
    } else {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return ProductTradeListCard(
            product: data,
            onPressed: () async {
              Xloading.showLoading(context);
              await managerController
                  .getSingleProduct(produitId: data.produitId)
                  .then((_) {
                Xloading.dismiss();
              });
            },
          );
        },
      );
    }
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
                    widget.produitDetails.user.nom
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
                widget.produitDetails.user.nom,
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
                initialRating: widget.produitDetails.user.cote.toDouble(),
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
                        widget.produitDetails.user.email,
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
                        widget.produitDetails.user.telephone,
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
            ],
          )
        ],
      ),
    );
  }

  Widget headerStack() {
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
              if (widget.produitDetails.images.isNotEmpty) ...[
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
                    itemCount: widget.produitDetails.images.length,
                    onPageChanged: (value) {
                      setState(() {
                        _selectedImageIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      var image = widget.produitDetails.images[index];
                      return CachedNetworkImage(
                        imageUrl: image.mediaUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height * .28,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
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
                                if (image.media != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoViewer(
                                        tag: image.produitMediaId,
                                        image: image.media,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoViewer(
                                        tag: image.produitMediaId,
                                        image: image.mediaUrl,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Container(),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          height: MediaQuery.of(context).size.height * .28,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(.2),
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
                        errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.height * .28,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.2),
                            borderRadius: BorderRadius.zero,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.3),
                                blurRadius: 12.0,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ] else ...[
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
                )
              ],
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: darkBlueColor.withOpacity(.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      widget.product.titre,
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 70,
                child: SlideBtn(
                    icon: CupertinoIcons.chevron_left,
                    onSlided: () {
                      if (_selectedImageIndex <= 0) {
                        return;
                      }
                      setState(() {
                        _selectedImageIndex--;
                      });
                      pageController.animateToPage(_selectedImageIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceInOut);
                    }),
              ),
              Positioned(
                right: 8,
                top: 70,
                child: SlideBtn(
                  icon: CupertinoIcons.chevron_right,
                  onSlided: () {
                    if (_selectedImageIndex ==
                        widget.produitDetails.images.length - 1) {
                      return;
                    }
                    setState(() {
                      _selectedImageIndex++;
                    });
                    pageController.animateToPage(_selectedImageIndex,
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

  viewSimularies(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.75,
        expand: false,
        builder: (_, controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.remove,
              color: Colors.grey[600],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Produits simulaires",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var data = products[index];
                    return ProductTradeListCard(
                      product: data,
                      onPressed: () async {},
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.6),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.2),
            offset: Offset.zero,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: onSlided,
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
              size: 18.0,
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
