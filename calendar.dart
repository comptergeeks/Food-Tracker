import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'reuseable.dart';
import 'food_tracker.dart';
import 'package:cupertino_calendar/cupertino_calendar.dart';
import 'services/manage_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarWithData extends StatefulWidget {
  const CalendarWithData({Key? key}) : super(key: key);

  @override
  State<CalendarWithData> createState() => _CalendarWithDataState();
}


class _CalendarWithDataState extends State<CalendarWithData> {
  List<Events> listOfEvents = [];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
    child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<UserToSave>().user)
        .collection('foodData')
        .snapshots(),
    builder: (context, snapshot) {
      final data = snapshot.requireData;
      return CupertinoCalendar(
            YearMonthRange(
            YearMonth.dateTime(DateTime.utc(2022, 1, 1)),
            YearMonth.dateTime(DateTime.utc(2025, 12, 31)),
          ),
        //stream builder returns date time list, and adds events based on snap shots
        dateReminds: DateRemindList(
          [

            ],
        ),
   );
            }
          ),
      );
  }
}
