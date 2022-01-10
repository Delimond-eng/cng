import '../index.dart';
import 'custom_header.dart';
import 'user_session_component.dart';

class GlobalHeader extends StatelessWidget {
  const GlobalHeader(
      {this.title, this.icon, this.isPageHeader = false, this.headerTextColor});
  final String title;
  final icon;
  final bool isPageHeader;
  final Color headerTextColor;

  @override
  Widget build(BuildContext context) {
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
                if (isPageHeader)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/$icon",
                        color: Colors.yellow[800],
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                else
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
                          icon,
                          color: primaryColor,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 5.0),
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: (headerTextColor == null)
                        ? Colors.black
                        : headerTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
            UserSession()
          ],
        ),
      ),
    );
  }
}
