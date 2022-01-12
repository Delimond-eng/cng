import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cng/components/custom_header.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/models/chat.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/pages/messages/widgets/custom_chat_bubble.dart';
import 'package:cng/pages/messages/widgets/image_bubble.dart';
import 'package:cng/services/api_manager.dart';
import 'package:cng/widgets/picked_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../index.dart';

class ChatDetailsPage extends StatefulWidget {
  final String messageSender;
  final String chatId;
  ChatDetailsPage({Key key, this.messageSender, this.chatId}) : super(key: key);

  @override
  _ChatDetailsPageState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final DateTime now = DateTime.now();

  StreamSubscription _streamSubscription;
  final ScrollController _controller = ScrollController();
  final TextEditingController textMessage = TextEditingController();
  FocusNode inputNode = FocusNode();

  @override
  void initState() {
    super.initState();
    initData();
    //scrollToDown();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  initData() async {
    try {
      _streamSubscription = streamChat.listen((result) {
        for (int i = 0; i < result.chats.length; i++) {
          if (result.chats[i].chatId == widget.chatId) {
            chatController.messages.value = result.chats[i].messages;
            //_controller.jumpTo(_controller.position.maxScrollExtent);
          }
        }
      });
    } catch (err) {
      print("error from stream message listener $err");
    }
  }

  Stream<ChatModel> get streamChat async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      var data = await ApiManager.viewChats();
      yield data;
    }
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
          children: [
            buildHeader(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10.0),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Scrollbar(
                  radius: const Radius.circular(10.0),
                  interactive: true,
                  thickness: 5,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Obx(() {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0;
                              i < chatController.messages.length;
                              i++) ...[
                            /*CustomDateChip(
                              date: chatController
                                  .messages[i].dateEnregistrement
                                  .trim()
                                  .split("|")[1]
                                  .trim(),
                            ),*/
                            if (chatController.messages[i].media == null) ...[
                              CustomChatBubble(
                                time: chatController
                                    .messages[i].dateEnregistrement
                                    .trim()
                                    .split("|")[0]
                                    .toString(),
                                text: chatController.messages[i].message,
                                isSender: chatController.messages[i].userId ==
                                        storage.read("userid").toString()
                                    ? false
                                    : true,
                                color: chatController.messages[i].userId ==
                                        storage.read("userid").toString()
                                    ? primaryColor
                                    : const Color(0xFFE8E8EE),
                                tail: true,
                                textStyle: GoogleFonts.lato(
                                  color: chatController.messages[i].userId ==
                                          storage.read("userid").toString()
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 16.0,
                                ),
                                delivered: true,
                              ),
                            ] else ...[
                              ImageBubble(
                                time: chatController
                                    .messages[i].dateEnregistrement
                                    .trim()
                                    .split("|")[0]
                                    .toString(),
                                image: chatController.messages[i].media,
                                sent: true,
                                isSender: chatController.messages[i].userId ==
                                        storage.read("userid").toString()
                                    ? true
                                    : false,
                              ),
                            ]
                          ],
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 12.0,
                    offset: const Offset(0.0, 10.0),
                  )
                ],
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: textMessage,
                        autofocus: false,
                        focusNode: inputNode,
                        style: const TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                          hintText: "Ecrire un message...",
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black54,
                            fontSize: 14.0,
                          ),
                          icon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              CupertinoIcons.pencil,
                              color: primaryColor,
                              size: 20.0,
                            ),
                          ),
                          border: InputBorder.none,
                          counterText: '',
                          suffixIcon: CustomGradientIconBtn(
                            onPressed: () async {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        PickerBtn(
                                          icon: CupertinoIcons
                                              .camera_on_rectangle,
                                          label: "Capture",
                                          onPressed: () async {
                                            var pickedFile = await takePhoto(
                                                src: ImageSource.camera);
                                            if (pickedFile != null) {
                                              var imageBytes =
                                                  File(pickedFile.path)
                                                      .readAsBytesSync();
                                              var strImage =
                                                  base64Encode(imageBytes);
                                              await sendMedia(
                                                  context, strImage);
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
                                            var pickedFile = await takePhoto(
                                                src: ImageSource.gallery);
                                            if (pickedFile != null) {
                                              var imageBytes =
                                                  File(pickedFile.path)
                                                      .readAsBytesSync();
                                              var strImage =
                                                  base64Encode(imageBytes);
                                              print(strImage);
                                              await sendMedia(
                                                  context, strImage);
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: CupertinoIcons.photo_camera_solid,
                            iconColor: Colors.black87,
                            gradient: LinearGradient(
                              colors: [
                                Colors.yellow[500],
                                accentColor,
                              ],
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.7),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: accentColor, width: 1.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            blurRadius: 12.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CustomGradientIconBtn(
                    onPressed: () => sendMessage(context),
                    icon: Icons.send_rounded,
                    iconColor: Colors.white,
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        secondaryColor,
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return CustomHeader(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 10.0,
          bottom: 10.0,
        ),
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
                  widget.messageSender,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
            Container(
              height: 40.0,
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    blurRadius: 5,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Voir produit",
                      style: GoogleFonts.lato(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage(context) async {
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
    Chat message = Chat(
      chatId: widget.chatId,
      message: textMessage.text,
      userId: storage.read("userid"),
    );
    await ApiManager.chatService(chat: message).then((res) {
      FocusScope.of(context).requestFocus(inputNode);
      setState(() {
        textMessage.text = "";
      });
      print(res);
    });
  }

  Future<void> sendMedia(context, String media) async {
    Chat message = Chat(
      chatId: widget.chatId,
      media: media,
      userId: storage.read("userid"),
    );
    await ApiManager.chatService(chat: message).then((res) {
      Get.back();
      print(res);
    });
  }
}

class CustomGradientIconBtn extends StatelessWidget {
  final Function onPressed;
  final Gradient gradient;
  final IconData icon;
  final Color iconColor;
  const CustomGradientIconBtn({
    Key key,
    this.onPressed,
    this.gradient,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        gradient: gradient,
        /*LinearGradient(
          colors: [
            Colors.yellow[500],
            accentColor,
          ],
        ),*/
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0.0, 10.0),
          )
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.0),
          onTap: onPressed,
          child: Center(
            child: Icon(
              //CupertinoIcons.photo_camera_solid,
              icon,
              color: iconColor,
              size: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
