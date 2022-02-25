import 'dart:convert';

import 'package:cng/constants/global.dart';
import 'package:cng/services/api_service.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  static UsersController instance = Get.find();

  Future userLogin({String identifier, String pwd}) async {
    var response;
    try {
      response = await ApiService.request(
        body: <String, dynamic>{
          "identifiant": identifier,
          "pass": pwd,
        },
        method: "post",
        url: "/connexion/account/login",
      );
    } catch (exception) {
      print("error from login $exception");
    }

    if (response != null) {
      var data = jsonDecode(response);

      var status = data['reponse']['status'];
      if (status.toString() == "success") {
        storage.write("userid", data["reponse"]["data"]["user_id"].toString());
        storage.write("username", data["reponse"]["data"]["nom"].toString());
        storage.write("useremail", data["reponse"]["data"]["email"].toString());
        storage.write(
            "telephone", data["reponse"]["data"]["telephone"].toString());
        return data;
      } else {
        return data;
      }
    } else {
      return null;
    }
  }

  Future userRegister({username, email, phone, pwd}) async {
    var response;
    try {
      response = await ApiService.request(
        body: <String, dynamic>{
          "nom": username,
          "email": email,
          "telephone": phone,
          "pass": pwd,
        },
        method: "post",
        url: "/connexion/account/registeraccount",
      );
    } catch (exception) {
      print("error from login $exception");
    }
    if (response != null) {
      var data = jsonDecode(response);
      var status = data['reponse']['status'];
      if (status == "success") {
        storage.write("userid", data["reponse"]["data"]["user_id"]);
        storage.write("username", data["reponse"]["data"]["nom"]);
        storage.write("useremail", data["reponse"]["data"]["email"]);
        storage.write("telephone", data["reponse"]["data"]["telephone"]);
        storage.write("pass", data["reponse"]["data"]["pass"]);
        return status;
      } else {
        return status;
      }
    } else {
      return null;
    }
  }
}
