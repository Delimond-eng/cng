// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cng/utils/permission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cng/components/global_header.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/widgets/bordered_textfield.dart';
import 'package:cng/widgets/costum_dropdown.dart';
import 'package:cng/widgets/picked_btn.dart';

import '../../../index.dart';

class AddVentePage extends StatefulWidget {
  const AddVentePage({Key key, this.subCategory}) : super(key: key);

  final List<SousCategories> subCategory;

  @override
  _AddVentePageState createState() => _AddVentePageState();
}

class _AddVentePageState extends State<AddVentePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final _formKey = GlobalKey<FormState>();

  List<String> images = [];
  List<FormulaireVenteDetails> subCatDetails = [];

  bool _isSelectedError = false;
  bool _isSelectedDeviseError = false;

  //controller nouveau produit step 01
  final TextEditingController controllerTitre = TextEditingController();
  final TextEditingController controllerDesc = TextEditingController();
  final TextEditingController controllerPrix = TextEditingController();
  SousCategories _selectedCategory;
  String _selectedDevise = "CDF";

  //controller detail produit step 3
  final TextEditingController controllerDetail = TextEditingController();
  List<ProductDetail> productDetails = [];
  ProductInfo infos;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageComponent(
        gradient: LinearGradient(
          colors: [
            primaryColor,
            primaryColor.withOpacity(.9),
            primaryColor.withOpacity(.5),
            Colors.white.withOpacity(.7),
            Colors.white.withOpacity(.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GlobalHeader(
              icon: CupertinoIcons.back,
              headerTextColor: Colors.white,
              isPageHeader: false,
              title: "Poster un produit ou service",
            ),
            const SizedBox(
              height: 10.0,
            ),
            tabHeader(),
            tabBody(),
          ],
        ),
      ),
    );
  }

  Widget tabBody() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: TabBarView(
          physics: const BouncingScrollPhysics(),
          controller: controller,
          children: [
            infosTab(),
            imagesTab(),
            detailsTabChild(),
          ],
        ),
      ),
    );
  }

  Widget infosTab() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Insérez les infos concernant votre produit ou service !",
                style: GoogleFonts.lato(
                  color: primaryColor,
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                height: 60.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: _isSelectedError ? Colors.red : primaryColor,
                      width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    menuMaxHeight: 300,
                    dropdownColor: Colors.white,
                    alignment: Alignment.centerRight,
                    borderRadius: BorderRadius.circular(5.0),
                    style: GoogleFonts.lato(color: Colors.black),
                    value: _selectedCategory,
                    hint: Text(
                      "Sélectionnez une sous catégorie",
                      style: GoogleFonts.mulish(
                        color: Colors.grey[600],
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    isExpanded: true,
                    items: widget.subCategory.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "${e.sousCategorie} ",
                            style:
                                GoogleFonts.lato(fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                        _isSelectedError = false;
                        subCatDetails = value.formulaireVenteDetails;

                        for (int i = 0; i < subCatDetails.length; i++) {
                          TextEditingController c = TextEditingController();
                          ProductDetail detail = ProductDetail(
                            controller: c,
                            detailId:
                                subCatDetails[i].produitSousCategorieDetailId,
                          );
                          productDetails.add(detail);
                        }
                      });
                    },
                  ),
                ),
              ),
              if (_isSelectedError)
                const SizedBox(
                  height: 5.0,
                ),
              if (_isSelectedError)
                Text(
                  "sélection réquise !",
                  style: GoogleFonts.lato(color: Colors.red, fontSize: 12.0),
                ),
              const SizedBox(
                height: 20.0,
              ),
              CostumFormTextField(
                errorText: "titre du produit ou service réquis",
                hintText: "Entrer le titre",
                expandedLabel: "Titre",
                icon: Icons.label_outline_sharp,
                controller: controllerTitre,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CostumFormTextField(
                errorText: "description du produit ou service réquis",
                hintText: "Entrer la description",
                expandedLabel: "Description",
                icon: Icons.description_outlined,
                controller: controllerDesc,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: CostumFormTextField(
                      errorText: "prix du produit ou service réquis",
                      hintText: "Entrer le prix et la devise",
                      expandedLabel: "Prix",
                      icon: CupertinoIcons.money_dollar_circle_fill,
                      controller: controllerPrix,
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    child: CostumDropdown(
                      array: const <String>["CDF", "USD"],
                      hintText: "USD",
                      value: _selectedDevise,
                      isError: _isSelectedDeviseError,
                      onChanged: (value) {
                        setState(() {
                          _selectedDevise = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: RaisedButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Suivant",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  elevation: 10.0,
                  onPressed: () async {
                    if (_selectedCategory == null) {
                      setState(() {
                        _isSelectedError = true;
                      });
                    }
                    if (_selectedDevise == null) {
                      setState(() {
                        _isSelectedDeviseError = true;
                      });
                    }
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _isSelectedError = false;
                        _isSelectedDeviseError = false;
                        infos = ProductInfo(
                          desc: controllerDesc.text,
                          devise: _selectedDevise,
                          titre: controllerTitre.text,
                          productSubCatId:
                              _selectedCategory.produitSousCategorieId,
                          userId: storage.read("userid"),
                        );
                        controller.index = 1;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imagesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
          child: Text(
            "Insérez les images illustratives concernant votre produit ou service !",
            style: GoogleFonts.lato(
              color: primaryColor,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        BtnDark(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              elevation: 2,
              barrierColor: Colors.black26,
              backgroundColor: Colors.white,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 100.0,
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PickerBtn(
                        icon: CupertinoIcons.camera_on_rectangle,
                        label: "Capture",
                        onPressed: () async {
                          var pickedListFile =
                              await takeMultiplePhoto(src: ImageSource.camera);
                          if (pickedListFile != null) {
                            for (var pickedFile in pickedListFile) {
                              var imageBytes =
                                  File(pickedFile.path).readAsBytesSync();
                              final result =
                                  await FlutterImageCompress.compressWithList(
                                imageBytes,
                                minHeight: 100,
                                minWidth: 100,
                                quality: 60,
                                format: CompressFormat.png,
                              );
                              var strImage = base64Encode(result);
                              setState(() {
                                images.add(strImage);
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      PickerBtn(
                        icon: CupertinoIcons.photo,
                        label: "Gallerie",
                        onPressed: () async {
                          var pickedFile =
                              await takePhoto(src: ImageSource.gallery);
                          if (pickedFile != null) {
                            var imageBytes =
                                File(pickedFile.path).readAsBytesSync();
                            final result =
                                await FlutterImageCompress.compressWithList(
                              imageBytes,
                              minHeight: 100,
                              minWidth: 100,
                              quality: 60,
                              format: CompressFormat.png,
                            );
                            var strImage = base64Encode(result);
                            setState(() {
                              images.add(strImage);
                            });
                          }
                        },
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Container(
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.20,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(images[index])),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5.0,
                        color: Colors.grey.withOpacity(.3),
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 50.0,
          width: double.infinity,
          // ignore: deprecated_member_use
          child: RaisedButton(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              "Suivant",
              style: GoogleFonts.lato(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            elevation: 5.0,
            onPressed: images.isEmpty
                ? null
                : () {
                    controller.index = 2;
                  },
          ),
        )
      ],
    );
  }

  Widget detailsTabChild() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
            child: Text(
              "Ajoutez les détails de votre produit ou service !",
              style: GoogleFonts.lato(
                color: primaryColor,
                fontSize: 18.0,
                letterSpacing: 1.0,
              ),
            ),
          ),
          if (subCatDetails.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Veuillez sélectionner une catégorie dans l'onglet infos !",
                      style: GoogleFonts.lato(
                        fontSize: 17.0,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      color: Colors.pink,
                      onPressed: () {
                        setState(() {
                          controller.index = 0;
                        });
                      },
                      child: Text(
                        "Voir catégorie",
                        style: GoogleFonts.lato(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ] else ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    for (int i = 0; i < subCatDetails.length; i++) ...[
                      DetailField(
                        subCatDetail: subCatDetails[i],
                        productDetail: productDetails[i],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ],
                ),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  // ignore: deprecated_member_use
                  child: RaisedButton.icon(
                    color: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    label: Text(
                      "Ajouter",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15.0,
                    ),
                    elevation: 5.0,
                    onPressed: subCatDetails.isEmpty
                        ? null
                        : () => _postArticle(context),
                  ),
                )
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget tabHeader() {
    return Container(
      width: double.infinity,
      height: 30.0,
      margin: const EdgeInsets.only(
        bottom: 20.0,
        right: 15.0,
        left: 15.0,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white, width: .5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BubbleTabIndicator(
          indicatorHeight: 30.0,
          indicatorColor: Colors.yellow[800],
          tabBarIndicatorSize: TabBarIndicatorSize.label,
          indicatorRadius: 20,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: GoogleFonts.mulish(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: GoogleFonts.mulish(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.label,
                      size: 12.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Infos".toUpperCase(),
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.photo_camera_solid,
                      size: 12.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Images".toUpperCase(),
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.description_rounded,
                      size: 12.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Détails".toUpperCase(),
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _postArticle(BuildContext context) async {
    var gpsData = await getUserLocate();
    if (images.isEmpty) {
      Get.snackbar(
        "Images du produit ou service requises !",
        "Veuillez ajouter au moins une image de votre produit ou service !",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.redAccent,
        backgroundColor: Colors.black45,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 5,
        duration: const Duration(seconds: 4),
      );
      setState(() {
        controller.index = 1;
      });
      return;
    }
    if (infos == null) {
      Get.snackbar(
        "infos sur le produit ou service requises !",
        "Veuillez décrire votre produit ou service !",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.redAccent,
        backgroundColor: Colors.black45,
        maxWidth: MediaQuery.of(context).size.width - 4,
        borderRadius: 5,
        duration: const Duration(seconds: 4),
      );
      setState(() {
        controller.index = 0;
      });
      return;
    }
    //first step
    Xloading.showLoading(context);
    var infosRes = await managerController.addNewProduct(
      data: <String, dynamic>{
        "user_id": infos.userId,
        "produit_sous_categorie_id": infos.productSubCatId,
        "titre": infos.titre,
        "description": infos.desc,
        "prix": infos.prix,
        "devise": infos.devise,
        "latitude": gpsData.latitude,
        "longitude": gpsData.longitude,
      },
      key: "nouveau",
    );

    if (infosRes["reponse"]["status"] == "success") {
      for (String img in images) {
        var _resImages = await managerController.addNewProduct(
          key: "image",
          data: <String, dynamic>{
            "user_id": storage.read("userid"),
            "produit_id": infosRes["reponse"]["produit_id"].toString(),
            "media": img
          },
        );
        print(_resImages);
      }
      if (productDetails.isNotEmpty) {
        for (int i = 0; i < productDetails.length; i++) {
          var detailsRes = await managerController.addNewProduct(
            key: "detail",
            data: <String, dynamic>{
              "user_id": storage.read("userid"),
              "produit_id": infosRes["reponse"]["produit_id"].toString(),
              "produit_sous_categorie_detail_id": productDetails[i].detailId,
              "produit_detail": productDetails[i].controller.text,
            },
          );
          print(detailsRes);
        }
      }
      Xloading.dismiss();
      XDialog.showSuccessAnimation(context);
      Future.delayed(const Duration(milliseconds: 500), () {
        managerController.refreshDatas();
      });
    }
  }
}

class DetailField extends StatelessWidget {
  const DetailField({
    Key key,
    this.subCatDetail,
    this.productDetail,
  }) : super(key: key);

  final FormulaireVenteDetails subCatDetail;
  final ProductDetail productDetail;

  @override
  Widget build(BuildContext context) {
    return CostumFormTextField(
      controller: productDetail.controller,
      expandedLabel: subCatDetail.sousCategorieDetail,
      errorText: "${subCatDetail.sousCategorieDetail} requis(e) !",
      hintText: "Saisir une valeur",
      icon: CupertinoIcons.pencil,
    );
  }
}

class ProductDetail {
  TextEditingController controller;
  String detailId;
  ProductDetail({
    this.controller,
    this.detailId,
  });
}

class ProductInfo {
  String userId, titre, desc, prix, devise, productSubCatId;
  ProductInfo(
      {this.devise, this.titre, this.desc, this.userId, this.productSubCatId});
}
