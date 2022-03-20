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
import 'package:cupertino_list_tile/cupertino_list_tile.dart';

class DailyTracker extends StatefulWidget {
  const DailyTracker({Key? key}) : super(key: key);

  @override
  State<DailyTracker> createState() => DailyTrackerState();
}
class DailyTrackerState extends State<DailyTracker> {
  StoreMethods storeData = new StoreMethods();
  Icon returnIcon(AsyncSnapshot snapshot, int index) {
    final data = snapshot.requireData;
    //on tap feature to display sized box
    //maybe subtitle feature for allergy level 3(moderate)
    if(data.docs[index]['allergy'] == '0') {
      return Icon(CupertinoIcons.sun_max);
    }
    if(data.docs[index]['allergy'] == '1') {
      return Icon(CupertinoIcons.cloud_sun);
    }
    if(data.docs[index]['allergy'] == '2') {
      return Icon(CupertinoIcons.cloud_sun_rain);
    }
    if(data.docs[index]['allergy'] == '3') {
      return Icon(CupertinoIcons.cloud_drizzle);
    }
    if(data.docs[index]['allergy'] == '4') {
      return Icon(CupertinoIcons.cloud_bolt);
    }
    if(data.docs[index]['allergy'] == '5') {
      return Icon(CupertinoIcons.cloud_bolt_rain);
    }
    return Icon(CupertinoIcons.smiley);
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: <Widget>[
          headingForData('Food', 20, true),
          Expanded(
            flex: 3,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(context.read<UserToSave>().user)
                    .collection('foodData')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Align(
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(),
                  );
                  if(snapshot.data?.docs == 0) return Align(
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(),
                  );
                  //remove auto generated data
                   return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (!snapshot.hasData) return Align(
                          alignment: Alignment.center,
                          child: CupertinoActivityIndicator(),
                        );
                        final data = snapshot.requireData;
                        // List entries = [];
                        // entries.add('food': data.docs[index]['food']);
                        // Timestamp timestampFromData = data.docs[index]['time'];
                        // DateTime date  = timestampFromData.toDate();
                        // List listOfTimes= <DateTime>[];
                        // listOfTimes.add(date);
                        return CupertinoListTile(
                          trailing: returnIcon(snapshot, index),
                        title: Text('${data.docs[index]['food']}'),
                        subtitle: Text('${data.docs[index]['allergy']}'),
                          );
                      }
                      );
                }),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: (MediaQuery.of(context).size.height - 100),
              child: Align(
                alignment: Alignment.centerRight,
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
                          position: Tween<Offset>(
                                  begin: Offset(0.0, 1.0), end: Offset.zero)
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
          ),
        ],
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


//ADD DATA POP UP FOR INCORRECT FIELD
  uploadData() {
    if (mealController.text.isEmpty || allergyController.text.isEmpty) {
      print("please make sure all fields are fields are full");
    } else if (int.parse(allergyController.text) > 5 ||
        int.parse(allergyController.text) < 0) {
      print('please input a valid number');
    } else {
      Navigator.pop(context);
      //List<String> info = [mealController.text, allergyController.text];
      /*
      Map<String, String> dataMap = {
        "food": mealController.text,
        "allergenInfo": allergyController.text,
      };
      */

      storeData.storeData(mealController.text, allergyController.text,
          context.read<UserToSave>().user,DateTime.now());
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
