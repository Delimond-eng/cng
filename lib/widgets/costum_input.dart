import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class CostumInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final IconData icon;

  final bool isPassWord;
  final TextInputType keyType;
  final double radius;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CostumInput({
    Key key,
    this.controller,
    this.hintText,
    this.icon,
    this.isPassWord,
    this.keyType,
    this.radius,
    this.errorText,
  });

  @override
  _CostumInputState createState() => _CostumInputState();
}

class _CostumInputState extends State<CostumInput> {
  bool _isObscure = true;
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: errorText.isNotEmpty
              ? const EdgeInsets.only(bottom: 5.0)
              : const EdgeInsets.only(bottom: 0),
          padding: widget.isPassWord
              ? const EdgeInsets.only(bottom: 10.0, top: 15.0)
              : EdgeInsets.zero,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: widget.radius == null
                ? BorderRadius.circular(5.0)
                : BorderRadius.circular(widget.radius),
            color: Colors.white.withOpacity(.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 12.0,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: widget.isPassWord == false
              ? TextFormField(
                  controller: widget.controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        errorText = widget.errorText;
                      });
                      return "";
                    } else {
                      setState(() {
                        errorText = "";
                      });
                      return null;
                    }
                  },
                  onFieldSubmitted: (text) {
                    if (text.isEmpty) {
                      setState(() {
                        errorText = widget.errorText;
                      });
                      return "";
                    } else {
                      setState(() {
                        errorText = "";
                      });
                      return null;
                    }
                  },
                  style: const TextStyle(fontSize: 14.0),
                  keyboardType: widget.keyType ?? TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                    hintText: widget.hintText,
                    hintStyle:
                        GoogleFonts.lato(color: Colors.black54, fontSize: 12.0),
                    errorStyle:
                        GoogleFonts.lato(color: Colors.red, fontSize: 0),
                    icon: Container(
                      width: 50.0,
                      height: 50.0,
                      child: Icon(
                        widget.icon,
                        color: Colors.yellow[800],
                        size: 20.0,
                      ),
                    ),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                )
              : TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        errorText = widget.errorText;
                      });
                      return '';
                    } else {
                      setState(() {
                        errorText = "";
                      });
                      return null;
                    }
                  },
                  onFieldSubmitted: (text) {
                    if (text.isEmpty) {
                      setState(() {
                        errorText = widget.errorText;
                      });
                      return "";
                    } else {
                      setState(() {
                        errorText = "";
                      });
                      return null;
                    }
                  },
                  controller: widget.controller,
                  keyboardType: widget.keyType ?? TextInputType.text,
                  obscureText: _isObscure,
                  style: const TextStyle(fontSize: 14.0),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    errorText: '',
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    hintStyle: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 12.0,
                    ),
                    errorStyle: GoogleFonts.lato(
                      color: Colors.red,
                      fontSize: 0.0,
                    ),
                    icon: Container(
                      height: 50.0,
                      width: 50.0,
                      child: Icon(
                        CupertinoIcons.lock,
                        size: 20.0,
                        color: Colors.yellow[800],
                      ),
                    ),
                    border: InputBorder.none,
                    counterText: '',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure
                            ? CupertinoIcons.eye_solid
                            : CupertinoIcons.eye_slash_fill,
                        size: 15,
                        color: Colors.black54,
                      ),
                      color: Colors.black54,
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
        ),
        if (errorText.isNotEmpty)
          Text(
            errorText,
            style: GoogleFonts.lato(
              color: Colors.red,
              fontSize: 11.0,
            ),
          )
      ],
    );
  }
}
