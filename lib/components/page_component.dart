import '../index.dart';

class PageComponent extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  const PageComponent({Key key, this.child, this.gradient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          gradient: gradient == null
              ? LinearGradient(
                  colors: [
                    Colors.white.withOpacity(.5),
                    Colors.white.withOpacity(.4),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : gradient,
        ),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
