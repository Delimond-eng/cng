import 'package:cng/constants/global.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../index.dart';
import 'auth/auth_login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentImageIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<String> pictures = [
    "assets/images/shopping3.json",
    "assets/images/shopping2.json",
    "assets/images/shopping1.json",
  ];
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topRight,
            image: AssetImage("assets/images/linebg.png"),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                darkBlueColor.withOpacity(.8),
                darkBlueColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 10.0),
                child: RichText(
                  text: TextSpan(
                    text: "Bienvenue sur ",
                    style: GoogleFonts.anton(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: " Wenze ",
                        style: GoogleFonts.greatVibes(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: accentColor,
                        ),
                      ),
                      TextSpan(
                        text: " Teka & somba",
                        style: GoogleFonts.lato(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Platforme numérique de vente & achat des produits ou services entre particuliers.",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentImageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => Lottie.asset(
                    pictures[index],
                  ),
                  itemCount: pictures.length,
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < pictures.length; i++)
                          if (i == currentImageIndex)
                            SliderDot(true)
                          else
                            SliderDot(false)
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Voulez-vous acheter ou vendre ? ",
                    style: GoogleFonts.lato(
                      color: accentColor,
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ignore: deprecated_member_use
                    FlatButton(
                      padding: const EdgeInsets.all(10.0),
                      color: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        storage.write("first-start", true);
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: const HomeScreen(),
                            type: PageTransitionType.fade,
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Acheter",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        storage.write("first-start", true);
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: const AuthLogin(),
                            type: PageTransitionType.fade,
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Vendre",
                        style: GoogleFonts.lato(
                          color: primaryColor,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SliderDot extends StatelessWidget {
  bool isActive;
  SliderDot(this.isActive, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? accentColor : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
