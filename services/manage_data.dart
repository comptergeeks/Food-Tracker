import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:mealmanager/log_in.dart';

class StoreMethods {
  Future<void> storeData(addInfo) async{
    try {
       FirebaseFirestore.instance.collection('fooddata').add(addInfo);
  } on Exception catch(error) {
      print(error);
    }

  }
}