import 'dart:async';
import 'dart:convert';

import 'package:cng/constants/global.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/models/offer_model.dart';
import 'package:cng/models/products_model.dart';
import 'package:cng/models/single_product_model.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:cng/services/api_manager.dart';
import 'package:cng/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ManagerController extends GetxController {
  static ManagerController instance = Get.find();

  var homeProducts = <Product>[].obs;

  var homeCategories = <Config>[].obs;

  var userProducts = <Produits>[].obs;

  var products = <Product>[].obs;

  var userOffers = <Offres>[].obs;

  var singleProduct = SingleData().obs;

  //StreamSubscription _streamSubscription;

  @override
  onInit() {
    super.onInit();
    refreshDatas();
  }

  Future<void> refreshDatas() async {
    var products = await ApiManager.viewHomeDatas();
    if (products != null) {
      homeProducts.value = products.reponse.produits;
    }
    var configs = await ApiManager.viewCategories();
    if (configs != null) {
      homeCategories.value = configs.config;
    }
    viewUserProducts();
    //await viewOwnOffers();
  }

  viewUserProducts() async {
    if (storage.read("userid") != null) {
      var userData = await ApiManager.viewOwnProductsAndServices();
      userProducts.value = userData.produits;
    }
  }

  Future<void> viewProductByCategorie({id}) async {
    var data = await ApiManager.getProductByCategory(key: "category", id: id);
    if (data != null) {
      products.value = data;
    }
  }

  Future<void> viewProductBySubCategorie({id}) async {
    var data =
        await ApiManager.getProductByCategory(key: "subcategory", id: id);
    if (data != null) {
      products.value = data;
    }
  }

  Future addNewProduct({String key, Map<String, dynamic> data}) async {
    var response;
    try {
      switch (key) {
        case "nouveau":
          response = await ApiService.request(
            body: data,
            method: "post",
            url: "/users/produits/nouveau",
          );
          break;
        case "image":
          response = await ApiService.request(
              body: data,
              method: "post",
              url: "/users/produits/nouveau/ajouterimage");
          break;
        case "detail":
          response = await ApiService.request(
            body: data,
            method: "post",
            url: "/users/produits/nouveau/ajouterdetail",
          );
          break;
      }
    } catch (exception) {
      print("error from product add void $exception");
    }

    if (response != null) {
      var data = jsonDecode(response);
      //viewOwnProductsAndServices();
      return data;
    } else {
      return null;
    }
  }

  Future<void> getSingleProduct({String produitId}) async {
    try {
      var result = await ApiService.request(
        url: "/content/produit",
        body: <String, dynamic>{
          "produit_id": produitId,
        },
        method: "post",
      );

      if (result != null) {
        var json = jsonDecode(result);
        var data = SingleProductModel.fromJson(json);
        singleProduct.value = data.singleData;
      }
    } catch (err) {
      print("error from home getdata void $err");
    }
  }

  Future<void> getProductsByCategory({String productSubCatId}) async {
    try {
      var result = await ApiService.request(
        url: "/content/souscategorie",
        body: <String, dynamic>{
          "produit_sous_categorie_id": productSubCatId,
        },
        method: "post",
      );

      if (result != null) {
        var json = jsonDecode(result);
        var data = SingleProductModel.fromJson(json);
        singleProduct.value = data.singleData;
      }
    } catch (err) {
      print("error from home getdata void $err");
    }
  }

  Future envoyerOffre(context, {String produitId, String montant}) async {
    var userId = storage.read("userid");

    if (userId != null) {
      try {
        var result = await ApiService.request(
          url: "/users/offres/envoyer",
          method: "post",
          body: <String, dynamic>{
            "user_id": userId,
            "produit_id": produitId,
            "montant": montant
          },
        );
        if (result != null) {
          var json = jsonDecode(result);
          if (json["error"] != null) {
            return null;
          }
          return json;
        } else {
          return null;
        }
      } catch (err) {
        print("error from home getdata void $err");
      }
    } else {
      Navigator.push(
        context,
        PageTransition(
          child: AuthLogin(),
          type: PageTransitionType.leftToRightWithFade,
        ),
      );
    }
  }

  Future<void> viewOwnOffers() async {
    var userId = storage.read("userid");
    if (userId != null) {
      try {
        var result = await ApiService.request(
          url: "/users/offres/voir",
          method: "post",
          body: <String, dynamic>{
            "user_id": userId,
          },
        );
        if (result != null) {
          var json = jsonDecode(result);
          if (json["error"] != null) {
            print(json);
            return;
          }
          var data = OfferModel.fromJson(json);
          userOffers.value = data.offres;
        }
      } catch (err) {
        print("error from home getdata void $err");
      }
    }
  }
}
