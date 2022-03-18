import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'reuseable.dart';
import 'food_tracker.dart';
import 'package:cupertino_calendar/cupertino_calendar.dart';

class CalendarWithData extends StatefulWidget {
  const CalendarWithData({Key? key}) : super(key: key);

  @override
  State<CalendarWithData> createState() => _CalendarWithDataState();
}

class _CalendarWithDataState extends State<CalendarWithData> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoCalendar(
        YearMonthRange(
          YearMonth.dateTime(DateTime.utc(2022, 1, 1)),
          YearMonth.dateTime(DateTime.utc(2025, 12, 31)),
        ),
        dateReminds: DateRemindList(
          [
            

          ],
        ),
      ),
    );
  }
}
