// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlesineintry/models/note.dart';
import 'package:googlesineintry/resorces/notification_managers.dart';
import 'package:googlesineintry/thems.dart';

class NotificationScreen extends StatefulWidget {
  Note? note;

  NotificationScreen({Key? key, this.note}) : super(key: key);
  // Note? note;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // DateTime timeSelected =

  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        color: const Color(0xff757575),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            // BorderRadius.only(topLeft: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 20, left: 10),
                margin: const EdgeInsets.all(10),
                // color: Colors.blue,
                height: 40,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: InkWell(
                  onTap: selectedDateandTime,
                  child: const Text(
                    "shedule ",
                    style: TextStyle(color: white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(right: 20, left: 10),
                margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: InkWell(
                  child: const Text(
                    "shedule notification",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    NotificationManager()
                        .callNotificationAfterDelay(selectedDate, widget.note);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> selectedDateandTime() async {
    DateTime? date = await selectDate();
    if (date == null) return;
    TimeOfDay? time = await selectTime();
    if (time == null) return;

    final DateTime? dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    selectedDate = dateTime;
  }

  Future<DateTime?> selectDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2025),
      );

  Future<TimeOfDay?> selectTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
      );
}

// selectDateandTime() async {
//   await selectDate();
//   await selectTime();
// }

class NotificationClick extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final getFunction;
  final String title;
  const NotificationClick({
    Key? key,
    required this.getFunction,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: ,
      height: 40,
      color: white,
      child: InkWell(
        child: Text(title),
        onTap: getFunction,
      ),
    );
  }
}
