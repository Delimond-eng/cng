import 'package:cng/widgets/costum_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../index.dart';

class AuthRegister extends StatefulWidget {
  const AuthRegister({Key key}) : super(key: key);

  @override
  _AuthRegisterState createState() => _AuthRegisterState();
}

class _AuthRegisterState extends State<AuthRegister> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController controllerNom = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
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
                primaryColor.withOpacity(.8),
                primaryColor.withOpacity(.4),
                primaryColor.withOpacity(.4),
                primaryColor.withOpacity(.4),
                Colors.white.withOpacity(.7),
                Colors.white.withOpacity(.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/icons/app_icon.png"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.yellow[800],
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Text(
                        "Veuillez créer à votre compte !",
                        style: GoogleFonts.lato(
                          color: Colors.grey[200],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20.0,
                    ),
                    alignment: Alignment.bottomCenter,
                    height: MediaQuery.of(context).size.height * .65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12.0,
                          color: Colors.black.withOpacity(.1),
                          offset: const Offset(0, 10.0),
                        )
                      ],
                    ),
                    child: Container(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                          top: 30.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CostumInput(
                                radius: 30.0,
                                hintText: "Nom complet",
                                icon: CupertinoIcons.person,
                                isPassWord: false,
                                errorText: "nom réquis !",
                                controller: controllerNom,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CostumInput(
                                radius: 30.0,
                                hintText: "Email",
                                icon: CupertinoIcons.envelope,
                                isPassWord: false,
                                errorText: "adresse email réquis !",
                                controller: controllerEmail,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CostumInput(
                                radius: 30.0,
                                hintText: "N° de téléphone",
                                isPassWord: false,
                                icon: CupertinoIcons.phone,
                                errorText: "n° de téléphone réquis !",
                                controller: controllerPhone,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CostumInput(
                                radius: 30.0,
                                hintText: "Mot de passe",
                                isPassWord: true,
                                errorText: "mot de passe réquis !",
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
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      Xloading.showLoading(context);
                                      await usersController
                                          .userRegister(
                                        username: controllerNom.text,
                                        email: controllerEmail.text,
                                        phone: controllerPhone.text,
                                        pwd: controllerPwd.text,
                                      )
                                          .then((result) async {
                                        Xloading.dismiss();
                                        if (result == "success") {
                                          await XDialog.showSuccessAnimation(
                                              context);
                                          await Future.delayed(
                                              const Duration(seconds: 2), () {
                                            Get.back();
                                          });
                                        } else {
                                          Get.snackbar(
                                            "Error !",
                                            "utilisateur existe déjà!",
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
                                        }
                                      });
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  color: accentColor,
                                  child: Text(
                                    'créer'.toUpperCase(),
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      letterSpacing: 1.0,
                                    ),
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
                                      "Vous avez pas un compte ?",
                                      style: GoogleFonts.lato(
                                        color: Colors.grey[700],
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Connectez-vous.",
                                        style: GoogleFonts.lato(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.w600,
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
