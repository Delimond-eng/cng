import 'package:cng/constants/global.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/services/api_manager.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find();

  // ignore: deprecated_member_use, prefer_collection_literals
  var messages = List<Messages>().obs;

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
