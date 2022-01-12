import 'package:cng/components/custom_header.dart';
import 'package:cng/components/user_session_component.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/services/api_manager.dart';
import 'package:cng/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../index.dart';
import 'pages/chat_details_page.dart';
import 'widgets/chat_card.dart';
import 'widgets/chat_home_shimmer.dart';

class MessagesViewPage extends StatefulWidget {
  MessagesViewPage({Key key}) : super(key: key);

  @override
  _MessagesViewPageState createState() => _MessagesViewPageState();
}

class _MessagesViewPageState extends State<MessagesViewPage> {
  Stream<List<Chats>> get streamMessages async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      var data = await chatController.viewChats();
      yield data;
    }
  }

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
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.5),
                Colors.white.withOpacity(.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                buildHeader(),
                Expanded(
                  child: Container(
                    child: StreamBuilder(
                      stream: streamMessages,
                      builder: (context, AsyncSnapshot<List<Chats>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ChatListLoading();
                        } else {
                          if (snapshot.hasData) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("Aucune discussion en cours !"),
                              );
                            } else {
                              return Scrollbar(
                                radius: const Radius.circular(5.0),
                                thickness: 4.0,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    bottom: 15.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data[index];
                                    return ChatCard(
                                      data: data,
                                      onPressed: () async {
                                        chatController.messages.clear();
                                        chatController.messages.addAll(
                                            snapshot.data[index].messages);
                                        await Navigator.push(
                                          context,
                                          PageTransition(
                                            child: ChatDetailsPage(
                                              messageSender: data.users
                                                  .firstWhere((e) =>
                                                      e.userId !=
                                                      storage
                                                          .read("userid")
                                                          .toString())
                                                  .nom,
                                              chatId: data.chatId,
                                              produitId: data.produitId,
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
                            }
                          } else {
                            return const Text("Aucune discussion en cours !");
                          }
                        }
                      },
                    ),
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
