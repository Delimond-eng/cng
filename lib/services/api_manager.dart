import 'dart:convert';

import 'package:cng/constants/global.dart';
import 'package:cng/models/chat.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/models/products_model.dart';
import 'package:cng/models/user_product_model.dart';
import 'package:cng/utils/permission.dart';

import 'api_service.dart';

class ApiManager {
  static Future<MenuConfigModel> viewCategories() async {
    var result;
    DateTime _now = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().hour);
    int nowTimestamp = _now.microsecondsSinceEpoch;
    if (storage.read('$nowTimestamp') == null) {
      try {
        result = await ApiService.request(
          url: "/content/config/menu",
          method: "get",
        );
        storage.write('$nowTimestamp', result);
      } catch (err) {
        print("error from home getdata void $err");
      }
    } else {
      DateTime _lastTime = _now.subtract(const Duration(hours: 1));
      int _lastTimestamp = _lastTime.microsecondsSinceEpoch;
      storage.remove('$_lastTimestamp');
      result = storage.read('$nowTimestamp');
    }

    if (result != null) {
      var json = jsonDecode(result);
      return MenuConfigModel.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<ProductsModel> viewHomeDatas() async {
    var gpsData = await getUserLocate();
    double lat = gpsData.latitude;
    double lng = gpsData.longitude;
    var result;
    try {
      result = await ApiService.request(
        url: "/content/home",
        method: "post",
        body: {
          "longitude": lng,
          "latitude": lat,
        },
      );
    } catch (err) {
      print("error from home get home product void $err");
    }
    if (result != null) {
      var json = jsonDecode(result);
      return ProductsModel.fromJson(json);
    } else {
      return null;
    }
  }

  static Future<UserProducts> viewOwnProductsAndServices() async {
    var result;
    try {
      var userId = storage.read("userid");
      if (userId != null) {
        result = await ApiService.request(
          body: <String, dynamic>{
            "user_id": userId,
          },
          url: "users/produits/voir",
          method: "post",
        );
      }
    } catch (exc) {
      print("error from view user products & services void $exc");
    }

    if (result != null) {
      var json = jsonDecode(result);
      return UserProducts.fromJson(json);
    } else {
      return null;
    }
  }

  static Future acceptOrRejectOffer({String offerId, String reponse}) async {
    var result;
    try {
      var userId = storage.read("userid");
      if (userId != null) {
        result = await ApiService.request(
          body: <String, dynamic>{
            "user_id": userId,
            "offre_id": offerId,
            "reponse": reponse
          },
          url: "/users/offres/repondre",
          method: "post",
        );
      }
    } catch (exc) {
      print("error from view products & services void $exc");
    }
    if (result != null) {
      var json = jsonDecode(result);
      if (json["error"] != null) {
        return null;
      }
      return json;
    } else {
      return null;
    }
  }

  static Future chatService({Chat chat}) async {
    var userId = storage.read("userid");
    var response;
    try {
      response = await ApiService.request(
        body: chat.toMap(),
        url: "/users/chats/send",
        method: "post",
      );
    } catch (err) {
      print("error from chating $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return json;
    } else {
      return null;
    }
  }

  static Future<ChatModel> viewChats() async {
    var userId = storage.read("userid");
    var response;

    try {
      response = await ApiService.request(
        body: <String, dynamic>{
          "user_id": userId,
        },
        url: "/users/chats",
        method: "post",
      );
    } catch (err) {
      print("error from view chats $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return ChatModel.fromJson(json);
    } else {
      return null;
    }
  }

  static Future deleteProduct({productId}) async {
    var userId = storage.read("userid");
    var response;
    try {
      response = await ApiService.request(
        body: {
          "user_id": userId,
          "produit_id": productId,
        },
        method: "post",
        url: "/users/produits/supprimer",
      );
    } catch (err) {
      print("error from delete statment ! $err");
    }
    if (response != null) {
      var json = jsonDecode(response);
      if (json["error"] != null) {
        return null;
      }
      return json;
    } else {
      return null;
    }
  }

  static Future<List<Product>> getProductByCategory({String key, id}) async {
    var response;
    try {
      switch (key) {
        case "category":
          response = await ApiService.request(
            body: {"produit_categorie_id": id},
            method: "post",
            url: "/content/categorie",
          );
          break;
        case "subcategory":
          response = await ApiService.request(
            body: {"produit_sous_categorie_id": id},
            method: "post",
            url: "/content/souscategorie",
          );
      }
    } catch (err) {
      print("error from delete statment ! $err");
    }
    if (response != null) {
      print(response);
      List<Product> products = [];
      var json = jsonDecode(response);
      if (json["content"]["produits"] != null &&
          json["content"]["produits"].isNotEmpty) {
        json["content"]["produits"].forEach((e) {
          products.add(Product.fromJson(e));
        });
      }

      return products;
    } else {
      return null;
    }
  }
}
