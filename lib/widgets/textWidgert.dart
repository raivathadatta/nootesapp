import 'package:flutter/material.dart';

import '../thems.dart';

class TextFeldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hint;
  final TextInputType type;
  final Icon icon;
  const TextFeldInput(
      {Key? key,
      required this.textEditingController,
      required this.hint,
      required this.ispass,
      required this.type,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: TextField(
            // decoration: const InputDecoration(),
            controller: textEditingController,
            keyboardType: type,
            obscureText: ispass,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
              hintText: hint,
              prefixIcon: icon,
              labelStyle: const TextStyle(
                color: kTextFieldColor,
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
          ),
        ));
  }
}
