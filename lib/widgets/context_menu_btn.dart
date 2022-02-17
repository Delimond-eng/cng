import '../index.dart';

class ContextMenuBtn extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Function onPressed;
  const ContextMenuBtn({
    Key key,
    this.icon,
    this.title,
    this.onPressed,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor ?? accentColor,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: Colors.grey[100],
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
