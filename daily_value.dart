import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'reuseable.dart';
import 'main.dart';
import 'daily_value.dart';

class DailyTracker extends StatefulWidget {
  const DailyTracker({Key? key}) : super(key: key);

  @override
  State<DailyTracker> createState() => DailyTrackerState();
}

class DailyTrackerState extends State<DailyTracker> {
  TextEditingController mealController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SizedBox (
      height: (MediaQuery.of(context).size.height - 100.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: CupertinoButton(
          child: Icon(
            CupertinoIcons.plus_circle,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (_, anim1, anim2) =>
                    SlideTransition(
                      position: Tween<Offset>(
                          begin: Offset(0.0, 1.0),
                          end: Offset.zero)
                          .animate(anim1),
                      child: AlertDialogForData(),
                    ),
              ),
            );
            // showCupertinoDialog(
                // context: context,
                // builder: (context) {
                // return AlertDialogForData();
                // }
            // );
          },
        ),
      ),
      ),
    );
  }
}

class AlertDialogForData extends StatefulWidget {
  const AlertDialogForData({Key? key}) : super(key: key);

  @override
  State<AlertDialogForData> createState() => _AlertDialogForDataState();
}

class _AlertDialogForDataState extends State<AlertDialogForData> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Error'),
      content: Text('plz work '),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: CupertinoTextField(
          ),
        ),
      ],
    );
  }
}


