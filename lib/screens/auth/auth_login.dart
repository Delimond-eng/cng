import 'package:cng/widgets/costum_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../index.dart';
import 'auth_register.dart';

class AuthLogin extends StatefulWidget {
  AuthLogin({Key key}) : super(key: key);

  @override
  _AuthLoginState createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerIdentifier = TextEditingController();
  final TextEditingController controllerPwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/shapes/shapeheader.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                darkBlueColor,
                darkBlueColor,
                primaryColor,
                primaryColor.withOpacity(.4),
                primaryColor.withOpacity(.4),
                primaryColor.withOpacity(.4),
                Colors.white.withOpacity(.4),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.85),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Positioned(
                          top: -35,
                          left: 0,
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/icons/logo_white.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Text(
                      "Connectez-vous à votre compte !",
                      style: GoogleFonts.lato(
                        color: Colors.grey[200],
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20.0,
                    ),
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height * .45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Colors.black.withOpacity(.1),
                          offset: const Offset(0, 10.0),
                        )
                      ],
                    ),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            top: 30.0,
                          ),
                          child: Column(
                            children: [
                              CostumInput(
                                hintText: "Email / n° téléphone",
                                icon: CupertinoIcons.person,
                                isPassWord: false,
                                errorText: "email ou téléphone réquis!",
                                controller: controllerIdentifier,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CostumInput(
                                hintText: "Mot de passe",
                                errorText: "mot de passe réquis !",
                                isPassWord: true,
                                controller: controllerPwd,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                // ignore: deprecated_member_use
                                child: RaisedButton(
                                  elevation: 10.0,
                                  onPressed: () {
                                    /**/
                                    if (_formKey.currentState.validate()) {
                                      Xloading.showLoading(context);
                                      usersController
                                          .userLogin(
                                        identifier: controllerIdentifier.text,
                                        pwd: controllerPwd.text,
                                      )
                                          .then((result) async {
                                        if (result["reponse"]['status'] ==
                                            "failed") {
                                          Xloading.dismiss();
                                          Get.snackbar(
                                            "Invalide !",
                                            "${result["reponse"]["message"]}",
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.redAccent,
                                            backgroundColor: Colors.black45,
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                4,
                                            borderRadius: 2,
                                            duration:
                                                const Duration(seconds: 5),
                                          );
                                          return;
                                        } else {
                                          await managerController
                                              .refreshDatas();
                                          Xloading.dismiss();
                                          await Navigator.pushAndRemoveUntil(
                                            context,
                                            PageTransition(
                                              child: HomeScreen(),
                                              type: PageTransitionType
                                                  .leftToRightWithFade,
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        }
                                      });
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Colors.yellow[900],
                                  child: Icon(
                                    Icons.arrow_right_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "Vous n'avez pas un compte ?",
                                      style: GoogleFonts.lato(
                                        color: Colors.grey[700],
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            child: AuthRegister(),
                                            type:
                                                PageTransitionType.bottomToTop,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Créer un compte.",
                                        style: GoogleFonts.lato(
                                          color: Colors.yellow[900],
                                          fontWeight: FontWeight.w700,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row costumAppTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          height: 60.0,
          width: 60.0,
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/micon.svg",
              color: Colors.yellow[800],
              alignment: Alignment.center,
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            style: GoogleFonts.lato(
              fontSize: 25,
              color: Colors.blue[900],
              fontWeight: FontWeight.w900,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'CNG  ',
                style: GoogleFonts.lato(
                  color: Colors.yellow[800],
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              TextSpan(
                text: 'Vendre & acheter',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
