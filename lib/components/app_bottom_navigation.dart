import 'package:google_fonts/google_fonts.dart';

import '../index.dart';

class AppBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  // ignore: prefer_typing_uninitialized_variables
  final onItemTapped;

  const AppBottomNavigation(
      {Key key, @required this.selectedIndex, @required this.onItemTapped})
      : super(key: key);

  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  List<dynamic> items = [
    {
      'icon': 'assets/icons/home-svgrepo-com.svg',
      'label': 'Acceuil',
    },
    {
      'icon': 'assets/icons/messages-svgrepo-com.svg',
      'label': 'Messages',
    },
    {
      'icon': 'assets/icons/note-add-svgrepo-com.svg',
      'label': 'Vendre',
    },
    {
      'icon': 'assets/icons/user-profile-svgrepo-com.svg',
      'label': 'Moi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.black87,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.lato(
          height: 1.5, fontSize: 12.0, fontWeight: FontWeight.w800),
      unselectedLabelStyle: GoogleFonts.lato(height: 1.5, fontSize: 12.0),
      selectedItemColor: Colors.yellow[900],
      elevation: 5,
      showSelectedLabels: true,
      items: items.map((i) {
        return BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            i['icon'],
            fit: BoxFit.scaleDown,
            color: Colors.yellow[900],
            height: 20.0,
            width: 20.0,
          ),
          icon: SvgPicture.asset(
            i['icon'],
            fit: BoxFit.scaleDown,
            color: Colors.black87,
            height: 20.0,
            width: 20.0,
          ),
          label: i['label'],
        );
      }).toList(),
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
    );
  }
}
