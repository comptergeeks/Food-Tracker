import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:mealmanager/log_in.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';

// var messageRef = db.collection('rooms').doc('roomA')
//                 .collection('messages').doc('message1')
class StoreMethods {
  Future<void> storeData(addInfo, String UserName) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(UserName).collection('foodData').add(addInfo);
    } on Exception catch (error) {
      print(error);
    }
  }
  getData(String UserName) async{
    return await FirebaseFirestore.instance.collection('users').doc(UserName).collection('foodData').get();

  }
}
