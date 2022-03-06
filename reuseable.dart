import 'package:flutter/cupertino.dart';
    CupertinoTextField textInput(String type, IconData? icon, bool isPass, TextEditingController controller, ) {
      return CupertinoTextField(
        controller: controller,
        placeholder: type,
        prefix: Icon(icon),
        obscureText: isPass,
        keyboardType: isPass
        ?TextInputType.text
        :TextInputType.emailAddress,
        autocorrect: false,
        enableSuggestions: false,
      );
    }
    Align textFieldHeader(String text, double size) {
        return Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.bold,),
        ),
      );
    }