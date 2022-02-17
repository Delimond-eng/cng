import 'dart:async';

import 'package:cng/constants/global.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/services/api_manager.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find();

  var messages = <Messages>[].obs;

  var chats = <Chats>[].obs;

  StreamSubscription subscription;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  @override
  void onClose() {
    super.onClose();
    subscription.cancel();
  }

  refreshData() async {
    subscription = streamMessages.listen((listenChats) {
      chats.value = listenChats;
    });
  }

  Stream<List<Chats>> get streamMessages async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      var data = await viewChats();
      yield data;
    }
  }

  Future<List<Chats>> viewChats() async {
    var userId = storage.read("userid");
    if (userId != null) {
      var data = await ApiManager.viewChats();
      if (data != null) {
        return data.chats;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
