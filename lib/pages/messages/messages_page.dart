import 'package:cng/components/custom_header.dart';
import 'package:cng/widgets/search_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';
import 'pages/chat_details_page.dart';

class MessagesViewPage extends StatefulWidget {
  MessagesViewPage({Key key}) : super(key: key);

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
                    child: Scrollbar(
                      radius: const Radius.circular(5.0),
                      thickness: 4.0,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0,
                        ),
                        itemBuilder: (context, index) {
                          return ChatCard(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: ChatDetailsPage(),
                                  type: PageTransitionType.leftToRightWithFade,
                                ),
                              );
                            },
                          );
                        },
                      ),
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
                        offset: const Offset(0.0, 10.0),
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.person,
                      size: 15.0,
                      color: Colors.grey[200],
                    ),
                  ),
                )
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

class ChatCard extends StatelessWidget {
  final Function onPressed;
  const ChatCard({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.8),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0.0, 10.0),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.5),
                        shape: BoxShape.circle,
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
                          CupertinoIcons.person,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 0,
                      child: Container(
                        height: 13.0,
                        width: 13.0,
                        decoration: BoxDecoration(
                          color: Colors.yellow[900],
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Gaston Delimond",
                      style: GoogleFonts.lato(
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet...",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
