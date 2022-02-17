import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../index.dart';

class Xloading {
  static dismiss() {
    Get.back();
  }

  static showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black26,
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: Lottie.asset(
                  "assets/lotties/90464-loading.json",
                  height: 300.0,
                  width: 300.0,
                  animate: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showSuccessAnimation(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(color: Colors.transparent),
              alignment: Alignment.center,
              width: 150.0,
              height: 200.0,
              child: Lottie.asset(
                "assets/lotties/84741-success.json",
                width: 150.0,
                height: 150.0,
                alignment: Alignment.center,
                animate: true,
                repeat: false,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  static show(context, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[800].withOpacity(.8),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_const_constructors
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
              if (title.isNotEmpty)
                const SizedBox(
                  width: 10,
                ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ],
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 10), () {
      Get.back();
    });
  }
}

//attribution_sharp

class XDialog {
  static void showCustomDialog(context,
      {String title, Widget modalContent, Function onSuccess}) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white12,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.white,
            elevation: 5, //this right here
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  color: primaryColor,
                  alignment: Alignment.topCenter,
                ),
              ],
            ),
          );
        });
  }

  static show(
      {BuildContext context,
      title,
      content,
      Function onValidate,
      Function onCancel,
      IconData icon}) {
    // set up the buttons
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text(
        "Annuler",
        style: GoogleFonts.mulish(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 1.0,
            color: Colors.red[400]),
      ),
      onPressed: onCancel ?? () => Get.back(),
    );
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text(
        "Valider",
        style: GoogleFonts.mulish(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: 1.0,
          color: Colors.green[700],
        ),
      ),
      onPressed: () {
        Get.back();
        Future.delayed(const Duration(microseconds: 500));
        onValidate();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            (icon == null) ? Icons.help_rounded : icon,
            color: Colors.amber[900],
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            width: 8,
          ),
          Text("$title")
        ],
      ),
      content: Text("$content"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showConfirmation(
      {BuildContext context,
      title,
      content,
      Function onCancel,
      IconData icon}) {
    // set up the buttons
    Widget cancelButton = Center(
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: const EdgeInsets.all(10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          "OK",
          style: GoogleFonts.mulish(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 1.0,
              color: Colors.red[400]),
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            (icon == null) ? Icons.help_rounded : icon,
            color: Colors.amber[900],
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            width: 8,
          ),
          Text("$title", style: GoogleFonts.lato(fontSize: 14))
        ],
      ),
      content: Text("$content"),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSuccessMessage(context, {title, message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[400],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "$title",
                style: GoogleFonts.mulish(color: Colors.white),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Colors.white),
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  static showSuccessAnimation(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(color: Colors.transparent),
              alignment: Alignment.center,
              width: 150.0,
              height: 200.0,
              child: Lottie.asset("assets/lotties/17828-success.json",
                  width: 150.0,
                  height: 150.0,
                  alignment: Alignment.center,
                  animate: true,
                  repeat: false,
                  fit: BoxFit.cover),
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  static Future<double> showCotation(context, {Function onCoted}) async {
    double cote = 1.0;
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: SingleChildScrollView(
            child: Stack(
              // ignore: deprecated_member_use
              overflow: Overflow.visible,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.8),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.4),
                        blurRadius: 12.0,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemSize: 30.0,
                        allowHalfRating: true,
                        unratedColor: Colors.grey.withOpacity(.7),
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange.withOpacity(.7),
                        ),
                        updateOnDrag: true,
                        onRatingUpdate: (double value) {
                          cote = value;
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        width: 100,
                        height: 40.0,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          elevation: 10.0,
                          color: Colors.white.withOpacity(.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Icon(CupertinoIcons.checkmark_alt,
                              color: Colors.green[700]),
                          onPressed: () {
                            print(cote);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red[200],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.4),
                            blurRadius: 12.0,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          CupertinoIcons.clear,
                          color: Colors.red[800],
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    return cote;
  }

  static showSuccessUserAlert(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          contentPadding: const EdgeInsets.all(8.0),
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.4),
                    blurRadius: 12.0,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              alignment: Alignment.center,
              width: 200.0,
              height: 200.0,
              child: Lottie.asset(
                "assets/lotties/82974-add-user.json",
                width: 150.0,
                height: 150.0,
                alignment: Alignment.center,
                animate: true,
                repeat: false,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  static showErrorAnimation(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          content: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            child: Lottie.asset("assets/lotties/32889-error-message.json",
                width: 150.0,
                height: 150.0,
                alignment: Alignment.center,
                animate: true,
                repeat: false,
                fit: BoxFit.cover),
          )),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  static showErrorMessage(context, {title, message, color}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white12,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: color ?? Colors.red[300],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("$title",
                  style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: GoogleFonts.mulish(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Colors.white),
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }
}

class Modal {
  static void show(context,
      {String title, Widget modalContent, double height}) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black38,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 8),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero), //this right here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, left: 5, right: 5, bottom: 5),
                          child: modalContent,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.yellow[900],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  title,
                                  style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                    shadows: [
                                      const Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.50),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                  // ignore: prefer_const_constructors
                                  icon: Icon(
                                    CupertinoIcons.clear_circled_solid,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
