import 'package:flutter/cupertino.dart';
import 'reuseable.dart';
import 'register.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'services/manage_data.dart';
import 'food_tracker.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DailyTracker extends StatefulWidget {
  const DailyTracker({Key? key}) : super(key: key);

  @override
  State<DailyTracker> createState() => DailyTrackerState();
}

class DailyTrackerState extends State<DailyTracker> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SizedBox(
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
                  pageBuilder: (_, anim1, anim2) => SlideTransition(
                    position:
                        Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
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
  TextEditingController mealController = TextEditingController();
  TextEditingController allergyController = TextEditingController();
  StoreMethods storeData = new StoreMethods();

  //QuerySnapshot? dataSnapshot;

  @override
  void initState() {
    super.initState();
    
    storeData.getData(context.read<UserToSave>().user ).then((result){
      //dataSnapshot = result;
    }
    );
  }

  uploadData() {
    if (mealController.text.isEmpty || allergyController.text.isEmpty) {
      print("please make sure all fields are fields are full");
    } else if (int.parse(allergyController.text) > 5 ||
        int.parse(allergyController.text) < 0) {
      print('please input a valid number');
    } else {
      Navigator.pop(context);
      Map<String, String> dataMap = {
        "food": mealController.text,
        "allergenInfo": allergyController.text,
      };
      storeData.storeData(dataMap, context.read<UserToSave>().user );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: 375,
        width: 350,
        decoration: BoxDecoration(
          color: CupertinoColors.systemTeal,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: <Widget>[
            headingForData('Enter Data', 20, true),
            const SizedBox(height: 30),
            headingForData('Food Consumed', 16, false),
            const SizedBox(height: 10),
            getData('Food Name', CupertinoIcons.cart_fill, mealController, 10),
            const SizedBox(height: 30),
            headingForData('Allergic Reaction?', 16, false),
            const SizedBox(height: 10),
            getData('Level of Reaction 1-5', CupertinoIcons.smiley,
                allergyController, 10),
            const SizedBox(height: 30),
            CupertinoButton.filled(
                child: Text(
                  'Submit',
                  style: TextStyle(color: CupertinoColors.white),
                ),
                onPressed: () {
                  String food = mealController.text,
                      reaction = allergyController.text;
                  uploadData();
                }),
          ],
        ),
      ),
    );
  }
}
