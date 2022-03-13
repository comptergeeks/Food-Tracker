import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reuseable.dart';
import 'main.dart';
import 'daily_value.dart';
class DailyTracker extends StatelessWidget {
  const DailyTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: AddFood(),

    );
  }
}

class AddFood extends StatelessWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:(MediaQuery.of(context).size.height - 100.0),
      child: Align(
        alignment: Alignment.bottomRight,
      child: CupertinoButton(
          child: Icon(
            CupertinoIcons.plus_circle,
            size: 30,),
        onPressed: () {},
      ),
    ),
    );
  }
}
