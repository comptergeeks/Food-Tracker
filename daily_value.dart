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
  List<Map> myList = [];
  StoreMethods storeData = new StoreMethods();
  Map dataToStore = new Map();
  Icon returnIcon(List<Map> myList1, int index) {
    //on tap feature to display sized box
    //maybe subtitle feature for allergy level 3(moderate)
    if(myList1[index]['allergyInfo'] == 0) {
      return Icon(CupertinoIcons.sun_max, color: CupertinoColors.activeGreen);
    }
    if(myList1[index]['allergyInfo'] == 1) {
      return Icon(CupertinoIcons.cloud_sun, color: CupertinoColors.systemYellow,);
    }
    if(myList1[index]['allergyInfo'] == 2) {
      return Icon(CupertinoIcons.cloud_sun_rain, color: CupertinoColors.systemOrange,);
    }
    if(myList1[index]['allergyInfo'] == 3) {
      return Icon(CupertinoIcons.cloud_drizzle, color: Color.fromARGB(
          255, 250, 100, 0));
    }
    if(myList1[index]['allergyInfo'] == 4) {
      return Icon(CupertinoIcons.cloud_bolt, color: CupertinoColors.systemRed,);
    }
    if(myList1[index]['allergyInfo'] == 5) {
      return Icon(CupertinoIcons.cloud_bolt_rain, color: CupertinoColors.destructiveRed,);
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
                  final data = snapshot.requireData;
                  myList.clear();
                    //place your code here. It will prevent double data call.
                    //print(snapshot.requireData.size);
                    for(int i = 0; i < snapshot.requireData.size; i++) {
                      dataToStore.addAll({
                        'food': '${data.docs[i]['food']}',
                        'allergyInfo': data.docs[i]['allergy']
                      });
                      myList.add({
                        'food': '${data.docs[i]['food']}',
                        'allergyInfo': data.docs[i]['allergy']
                      });
                    }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (!snapshot.hasData) return Align(
                          alignment: Alignment.center,
                          child: CupertinoActivityIndicator(),
                        );
                        //bubble sort method to order data by
                        for(int i = 0; i < myList.length -1; i++) {
                          for(int j = 0; j < myList.length - i - 1; j++) {
                            if(myList[j]['allergyInfo'] > myList[j + 1]['allergyInfo']) {
                              Map swapper = myList[j];
                              myList[j] = myList[j + 1];
                              myList[j + 1] = swapper;
                            }
                          }
                        }
                        //print(dataToStore.toString());
                        return CupertinoListTile(
                          trailing: returnIcon(myList, index),
                          title: Text(myList[index]['food']),
                          subtitle: Text(myList[index]['allergyInfo'].toString()),
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
    if(checkNumeric(allergyController.text) == true) {
    if (mealController.text.isEmpty || allergyController.text.isEmpty) {
      print("please make sure all fields are fields are full");
    } else if (int.parse(allergyController.text) > 5 ||
        int.parse(allergyController.text) < 0) {
      print('please input a valid number');
    } else {
      Navigator.pop(context);
      storeData.storeData(mealController.text, int.parse(allergyController.text),
          context.read<UserToSave>().user,DateTime.now());
    }
    } else{
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Error'),
              content: Text('Please make sure you enetered a valid number'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }
  bool checkNumeric(String passedAllergy) {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    return _numeric.hasMatch(passedAllergy);
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