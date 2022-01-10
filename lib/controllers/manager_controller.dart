// ignore_for_file: prefer_collection_literals, deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:cng/constants/global.dart';
import 'package:cng/models/offer_model.dart';
import 'package:cng/models/products_model.dart';
import 'package:cng/models/single_product_model.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:cng/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class ManagerController extends GetxController {
  static ManagerController instance = Get.find();

  var userProducts = List<Produits>().obs;

  var userOffers = List<Offres>().obs;

  var singleProduct = SingleData().obs;

  //StreamSubscription _streamSubscription;

  @override
  onInit() {
    super.onInit();
    refreshDatas();
  }

  @override
  onClose() {
    super.onClose();
    //_streamSubscription.cancel();
  }

  Future<void> refreshDatas() async {
    //await viewHomeDatas();
    /*_streamSubscription = streamHomeView().listen((data) {
      homeProducts.value = data.reponse.produits;
    });*/
    //await viewConfigDatas();
    await viewOwnProductsAndServices();
    //await viewOwnOffers();
  }

  Future addNewProduct({String key, Map<String, dynamic> data}) async {
    var response;
    try {
      switch (key) {
        case "nouveau":
          response = await ApiService.request(
              body: data, method: "post", url: "/users/produits/nouveau");
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
              url: "/users/produits/nouveau/ajouterdetail");
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

  Future<UserProducts> viewOwnProductsAndServices() async {
    var result;
    try {
      var userId = storage.read("userid");
      if (userId != null) {
        result = await ApiService.request(
          body: <String, dynamic>{
            "user_id": userId,
          },
          url: "/users/produits/voir",
          method: "post",
        );
      }
    } catch (exc) {
      print("error from view products & services void $exc");
    }
    if (result != null) {
      var json = jsonDecode(result);
      var data = UserProducts.fromJson(json);
      userProducts.value = data.produits;
      return data;
    } else {
      return null;
    }
  }

  Future<ProductsModel> viewHomeDatas() async {
    var result;
    try {
      result = await ApiService.request(
        url: "/content/home",
        method: "get",
      );
    } catch (err) {
      print("error from home getdata void $err");
    }
    if (result != null) {
      var json = jsonDecode(result);
      var data = ProductsModel.fromJson(json);
      return data;
    } else {
      return null;
    }
  }

  Future<ProductsModel> getDatas() async {
    var result;
    try {
      result = await ApiService.request(
        url: "/content/home",
        method: "get",
      );
    } catch (err) {
      print("error from home getdata void $err");
    }

    if (result != null) {
      var json = jsonDecode(result);
      var data = ProductsModel.fromJson(json);
      return data;
    } else {
      return null;
    }
  }

  Stream<ProductsModel> streamHomeView() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      var data = await getDatas();
      yield data;
    }
  }

  Stream<UserProducts> streamUserProducts() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      var data = await viewOwnProductsAndServices();
      yield data;
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
