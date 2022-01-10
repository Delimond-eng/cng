import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cng/components/custom_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../index.dart';

class ChatDetailsPage extends StatefulWidget {
  ChatDetailsPage({Key key}) : super(key: key);

  @override
  _ChatDetailsPageState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageComponent(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BubbleNormal(
                        text:
                            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto quam natus provident!',
                        isSender: false,
                        color: primaryColor,
                        tail: true,
                        textStyle: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      BubbleNormal(
                        text:
                            'Lorem ipsum dolor sit amet consectetur adipisicing elit!',
                        isSender: true,
                        color: const Color(0xFFE8E8EE),
                        tail: true,
                        sent: true,
                        textStyle: GoogleFonts.lato(
                          fontSize: 16.0,
                        ),
                      ),
                      DateChip(
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
                      BubbleSpecialOne(
                        text: 'bubble special one without tail',
                        tail: false,
                        color: const Color(0xFFE8E8EE),
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
                      BubbleSpecialTwo(
                        text: 'bubble special tow with tail',
                        isSender: true,
                        color: const Color(0xFFE8E8EE),
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
                      BubbleSpecialTwo(
                        text: 'bubble special tow without tail',
                        tail: false,
                        color: const Color(0xFFE8E8EE),
                        delivered: true,
                      ),
                    ],
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
                        style: const TextStyle(fontSize: 14.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                          hintText: "Ecrire votre message...",
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              CupertinoIcons.camera_on_rectangle_fill,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                            onPressed: () {
                              print("clicked !");
                            },
                          ),
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.7),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: primaryColor, width: 1.0),
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
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Colors.black.withOpacity(.1),
                          offset: const Offset(0.0, 10.0),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  )
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
                      color: Colors.white.withOpacity(.8),
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
                  "Gaston delimond",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
            Container(
              height: 40.0,
              width: 40.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 12.0,
                      color: Colors.black.withOpacity(.2),
                      offset: const Offset(0.0, 10.0))
                ],
              ),
              child: Center(
                child: Icon(CupertinoIcons.person,
                    size: 15.0, color: Colors.grey[200]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
