import 'dart:convert';

import 'package:cng/constants/global.dart';
import 'package:cng/models/chat.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/models/menu_config_model.dart';
import 'package:cng/models/products_model.dart';
import 'package:cng/models/user_product_model.dart';

import 'api_service.dart';

class ApiManager {
  static Future<MenuConfigModel> viewCategories() async {
    var result;
    try {
      result = await ApiService.request(
        url: "/content/config/menu",
        method: "get",
      );
    } catch (err) {
      print("error from home getdata void $err");
    }
    if (result != null) {
      var json = jsonDecode(result);
      var data = MenuConfigModel.fromJson(json);
      return data;
    } else {
      return null;
    }
  }

  static Future<ProductsModel> viewHomeDatas() async {
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

  static Future<UserProducts> viewOwnProductsAndServices() async {
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
      return data;
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
}
