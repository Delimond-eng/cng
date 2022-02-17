import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';
import 'pages/chat_details_page.dart';
import 'widgets/chat_card.dart';

class MessagesViewPage extends StatefulWidget {
  const MessagesViewPage({Key key}) : super(key: key);

  @override
  _MessagesViewPageState createState() => _MessagesViewPageState();
}

class _MessagesViewPageState extends State<MessagesViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/shapes/shapebg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.8),
          ),
          child: SafeArea(
            child: Column(
              children: [
                buildHeader(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30.0),
                      ),
                      color: Colors.white.withOpacity(.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: Offset.zero,
                          blurRadius: 10.0,
                        )
                      ],
                    ),
                    child: Obx(() {
                      return chatController.chats.isEmpty
                          ? const Center(
                              child: Text("Aucune discussion en cours !"),
                            )
                          : Scrollbar(
                              radius: const Radius.circular(5.0),
                              thickness: 4.0,
                              child: ListView.builder(
                                itemCount: chatController.chats.length,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(15.0),
                                itemBuilder: (context, index) {
                                  var data = chatController.chats[index];
                                  return ChatCard(
                                    data: data,
                                    onPressed: () async {
                                      chatController.messages.clear();
                                      chatController.messages
                                          .addAll(data.messages);
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          child: ChatDetailsPage(
                                            messageSender: data.users
                                                .firstWhere(
                                                  (e) =>
                                                      e.userId !=
                                                      storage
                                                          .read("userid")
                                                          .toString(),
                                                )
                                                .nom,
                                            chatId: data.chatId,
                                          ),
                                          type: PageTransitionType
                                              .leftToRightWithFade,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return CustomHeader(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/app_icon.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      'Messages',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                UserSession()
              ],
            ),
            const SizedBox(height: 8.0),
            const SearchBar()
          ],
        ),
      ),
    );
  }
}
