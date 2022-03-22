import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:mealmanager/log_in.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import 'package:cupertino_calendar/cupertino_calendar.dart';
import 'package:mealmanager/calendar.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class StoreMethods {
  Future<void> storeData(String food, int allergy, String UserName, DateTime time) async {
      try {
        FirebaseFirestore.instance.collection('users').doc(UserName).collection(
            'foodData').add(
            {'food': food, 'allergy': allergy, 'time': time}
        );
      } on Exception catch (error) {
        print(error);
      }
  }
  getData(String UserName) async{
    return await FirebaseFirestore.instance.collection('users').doc(UserName).collection('foodData').snapshots();
  }
  deleteData(String UserName) async{
    return await FirebaseFirestore.instance.collection('users').doc(UserName).collection('foodData').doc().delete();
  }
}

