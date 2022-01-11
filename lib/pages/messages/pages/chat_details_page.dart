import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cng/components/custom_header.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/models/chat_model.dart';
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

  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  initData() {
    try {
      _streamSubscription = streamChat.listen((result) {
        for (int i = 0; i < result.chats.length; i++) {
          if (result.chats[i].chatId == widget.chatId) {
            chatController.messages.value = result.chats[i].messages;
            scrollToDown();
          }
        }
      });
    } catch (err) {
      print("error from stream message listener $err");
    }
  }

  void scrollToDown() {
    /*_controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );*/
    _controller.jumpTo(_controller.position.maxScrollExtent);
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
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SingleChildScrollView(
                  controller: _controller,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Obx(() {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0;
                            i < chatController.messages.length;
                            i++) ...[
                          if (chatController.messages[i].media == null) ...[
                            BubbleSpecialOne(
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
                              isSender: chatController.messages[i].userId ==
                                      storage.read("userid").toString()
                                  ? true
                                  : false,
                            ),
                          ]
                        ],

                        /*DateChip(
                        date: DateTime(now.year, now.month, now.day - 2),
                      ),
                      BubbleNormal(
                        text:
                            'Lorem ipsum dolor sit amet consectetur adipisicing elit!',
                        isSender: false,
                        color: primaryColor,
                        tail: false,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                        ),
                      ),
                      BubbleNormal(
                        text:
                            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto quam natus provident!',
                        color: const Color(0xFFE8E8EE),
                        tail: false,
                        sent: true,
                        seen: true,
                        delivered: true,
                        textStyle: GoogleFonts.lato(
                          fontSize: 16.0,
                        ),
                      ),
                      BubbleSpecialOne(
                        text: 'Architecto quam natus provident!',
                        isSender: false,
                        color: primaryColor,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      DateChip(
                        date: DateTime(now.year, now.month, now.day - 1),
                      ),
                      BubbleSpecialOne(
                        text: 'bubble special one with tail',
                        color: const Color(0xFFE8E8EE),
                        textStyle: GoogleFonts.lato(
                          fontSize: 16.0,
                        ),
                        seen: true,
                      ),
                      BubbleSpecialOne(
                        text: 'bubble special one without tail',
                        isSender: false,
                        tail: false,
                        color: primaryColor,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                        ),
                      ),
                      const BubbleSpecialOne(
                        text: 'bubble special one without tail',
                        tail: false,
                        color: Color(0xFFE8E8EE),
                        sent: true,
                      ),
                      BubbleSpecialTwo(
                        text: 'bubble special tow with tail',
                        isSender: false,
                        color: primaryColor,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                        ),
                      ),
                      DateChip(
                        date: now,
                      ),
                      const BubbleSpecialTwo(
                        text: 'bubble special tow with tail',
                        isSender: true,
                        color: Color(0xFFE8E8EE),
                        sent: true,
                      ),
                      BubbleSpecialTwo(
                        text: 'bubble special tow without tail',
                        isSender: false,
                        tail: false,
                        color: primaryColor,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                        ),
                      ),
                      const BubbleSpecialTwo(
                        text: 'bubble special tow without tail',
                        tail: false,
                        color: Color(0xFFE8E8EE),
                        delivered: true,
                      ),
                      ImageBubble(
                        isSender: true,
                      ),*/
                      ],
                    );
                  }),
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
                    onPressed: () {},
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
}

class ImageBubble extends StatelessWidget {
  final bool isSender;
  final String image;
  final Function onPressed;
  const ImageBubble({
    Key key,
    this.isSender = false,
    this.image,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isSender
                  ? primaryColor.withOpacity(.15)
                  : Colors.black.withOpacity(.1),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
          image: const DecorationImage(
            image: AssetImage("assets/shapes/placeholder.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 120,
        width: 200.0,
      ),
    );
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
