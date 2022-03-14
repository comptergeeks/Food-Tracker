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
    Align textFieldHeader(String text, double size,) {
        return Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.bold,),
        ),
      );
    }

    Text headingForData(String name, double size, bool isHeading) {
      return Text(
        name,
        style: TextStyle(fontSize: size,
            fontWeight: isHeading
            ?FontWeight.bold
            :FontWeight.normal),
      );
    }

CupertinoTextField getData(String type, IconData? icon, TextEditingController controller, double space) {
  return CupertinoTextField(
    controller: controller,
    placeholder: type,
    prefix: Icon(icon),
    autocorrect: true,
    enableSuggestions: true,
    padding: EdgeInsets.all(space),
  );
}