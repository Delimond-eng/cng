// ignore_for_file: unused_import

import 'package:cng/constants/global.dart';
import 'package:cng/pages/favorites/favorite_page.dart';
import 'package:cng/pages/home/index.dart';
import 'package:cng/pages/messages/messages_page.dart';
import 'package:cng/pages/profils/profils_view_page.dart';
import 'package:cng/pages/ventes/ventes_view_page.dart';
import 'package:cng/screens/auth/auth_login.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const MessagesViewPage(),
      const VentesViewPage(),
      const ProfilsViewPage()
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      var userId = storage.read("userid");

      if (userId == null && _selectedIndex == 3) {
        Navigator.push(
          context,
          PageTransition(
            child: const AuthLogin(),
            type: PageTransitionType.leftToRightWithFade,
          ),
        );
        setState(() {
          _selectedIndex = 2;
        });
        return;
      }

      if (userId == null && _selectedIndex == 1) {
        Navigator.push(
          context,
          PageTransition(
            child: AuthLogin(),
            type: PageTransitionType.leftToRightWithFade,
          ),
        );
        setState(() {
          _selectedIndex = 0;
        });
        return;
      }
      pageController.jumpToPage(_selectedIndex);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: _onItemTapped,
        children: pages,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
