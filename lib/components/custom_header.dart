import '../index.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({this.child, this.hasColored = false, this.color});
  final Widget child;
  final bool hasColored;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: (hasColored)
          ? const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage("assets/shapes/shapeheader.jpg"),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(color: (color != null) ? color : Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          gradient: (hasColored)
              ? LinearGradient(
                  colors: [
                    primaryColor.withOpacity(.8),
                    primaryColor.withOpacity(.8),
                    Colors.white.withOpacity(.7)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        child: child,
      ),
    );
  }
}
