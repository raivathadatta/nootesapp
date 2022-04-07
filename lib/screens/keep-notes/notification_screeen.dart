import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:googlesineintry/models/note.dart';
import 'package:googlesineintry/resorces/notification_managers.dart';
import 'package:googlesineintry/thems.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen(Note? note, {Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();

  // DateTime timeSelected =

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff757575),
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            color: white,
          ),
          // borderRadius: BorderRadius.only(
          // topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(30),
                decoration: const BoxDecoration(color: Colors.grey),
                width: double.maxFinite,
                child: Column(
                  children: [
                    const Text(" select date "),
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.black),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: [
                          Container(
                            width: 80,
                            height: 40,
                            child: NotificationClick(
                              getFunction:
                                  selectDate, ////////////////////add function for create notification
                              title: "select date ",
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 40,
                            color: Color.fromARGB(255, 138, 62, 62),
                            child: NotificationClick(
                              getFunction:
                                  selectTime, ////////////////////add function for create notification
                              title: " time ",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 150,
                      height: 40,
                      color: Colors.blue,
                      child: InkWell(
                        child: const Text(
                          "shedule notification",
                          style: TextStyle(
                              color: white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          if (selectedDate != null && selectedTime != null) {
                            NotificationManager().callNotificationAfterDelay(
                                selectedDate, selectedTime);
                          } else {
                            const Text("plese select both");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const NotificationClick(
                getFunction: null, /////// add function for delete notification
                title: 'delete notification ',
              ),
              const SizedBox(height: 12),
              NotificationClick(
                title: 'shedule for today',
                getFunction: selectTime,
              ),
            ],
          ),
        ));
  }

  Future<void> selectDate() async {
    log("1");
    final DateTime? selected = await showDatePicker(
      context: context,
      // selectableDayPredicate:true;
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    // selected!.hour = 2;
    log(selected!.hour.toString() + "2222222");
    if (selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        // selected.hour = selectedTime.hour;
        // selected.minute = selectedTime.minute;
      });
      // selectedDate.hour = selectedTime.hour;
    }
  }

  Future<void> selectTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  // selectDateandTime() async {
  //   await selectDate();
  //   await selectTime();
  // }
}

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
