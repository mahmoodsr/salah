import 'dart:async';
import 'dart:ffi';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:calender_picker/extra/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:calender_picker/calender_picker.dart';
import 'package:intl/intl.dart';
import 'loading_screen.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:moon_phase/moon_phase.dart';
import 'package:provider/provider.dart';
import 'DataPrayer.dart';
import 'athkar.dart';

class HomeScreen extends StatelessWidget with ChangeNotifier {
  var day;
  String? fajirHours;
  String? sunriseHours;
  String? duhurHours;
  String? asrHours;
  String? maghribHours;
  String? ishaHours;

  late var month;
  late var year;

  var kTextFont =
      TextStyle(fontFamily: 'Quicksand', fontSize: 30.0, color: Colors.white);
  var kNextTextFont =
      TextStyle(fontFamily: 'Quicksand', fontSize: 32.0, color: Colors.amber);
  var kClockFont =
      TextStyle(fontFamily: 'Quicksand', fontSize: 35.0, color: Colors.white);
  var monthName = DateFormat('yMMMd').format(DateTime.now());

  var datex = DateTime.now();

  dynamic getTime(String time) {
    String split = time;

    var splitted = split.split(' ');

    var splitted2 = splitted[0].split(':');

    var lastHours = splitted2[0];
    var lastMin = splitted2[1];
    DateTime tempDate = DateFormat("hh:mm").parse(lastHours + ':' + lastMin);

    var dateFormat = DateFormat("h:mm a");

    return dateFormat.format(tempDate);
  }

  hoursCompared(String time) {
    var cut = time;
    late int x;
    var splitted = cut.split(' ');
    var splitted2 = splitted[0].split(':');

    var lastHours = splitted2[0];
    print(lastHours);
    x = int.parse(lastHours);
    return x;
  }

  minutesCompared(String time) {
    String? cut = time;
    var splitted = cut.split(':');

    var lastMinutes = splitted[1];
    print(lastMinutes);
    return int.parse(lastMinutes);
  }

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("H:m").format(now);
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      backgroundColor: Color(0xff484747),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 5.0,
                right: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Salah',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 35.0,
                        color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Athkar()),
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.handsPraying),
                    iconSize: 28.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 1.0,
            child: Divider(
              indent: 15.0,
              endIndent: 15.0,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  Provider.of<DataPrayer>(context, listen: false).nextPrayer(),
                  style: kNextTextFont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
              ),
              // SizedBox(
              //   width: 16,
              // ),
              Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: DigitalClock(
                    is24HourTimeFormat: false,
                    showSecondsDigit: false,
                    areaDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    hourMinuteDigitDecoration:
                        BoxDecoration(color: Colors.transparent),
                    hourMinuteDigitTextStyle: kClockFont,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 28, bottom: 3),
                child: MoonWidget(
                  date: datex,
                  size: 60,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              CalenderPicker(
                DateTime.now(),
                height: 70,
                monthTextStyle: const TextStyle(
                    backgroundColor: Colors.white,
                    fontSize: 200.0,
                    color: Colors.black),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black54,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  // // getData();
                  // .checkingTheBox(
                  // Provider.of<TaskDatas>(context, listen: false).x[index]);
                  datex = date;
                  Provider.of<DataPrayer>(context, listen: false)
                      .onDateChanged(date);
                  // monthName = DateFormat('yMMMd')
                  //     .format(DateTime(date.year, date.month, date.day));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            '${Provider.of<DataPrayer>(context, listen: false).monthName}',
            style: kTextFont,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 570,
            width: 380,
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  prayersTable(
                    prayer: 'Fajir',
                    timing:
                        getTime(Provider.of<DataPrayer>(context).prayers[0]),
                  ),
                  prayersTable(
                    prayer: 'Sunrise',
                    timing:
                        getTime(Provider.of<DataPrayer>(context).prayers[1]),
                  ),
                  prayersTable(
                    prayer: 'Duhur',
                    timing:
                        getTime(Provider.of<DataPrayer>(context).prayers[2]),
                  ),
                  prayersTable(
                    prayer: 'asr',
                    timing:
                        getTime(Provider.of<DataPrayer>(context).prayers[3]),
                  ),
                  prayersTable(
                    prayer: 'Maghrib',
                    timing:
                        getTime(Provider.of<DataPrayer>(context).prayers[4]),
                  ),
                  prayersTable(
                    prayer: 'Isha',
                    timing:
                        getTime(Provider.of<DataPrayer>(context).prayers[5]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class prayersTable extends StatelessWidget {
  prayersTable({required this.prayer, required this.timing});
  String prayer;
  String? timing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$prayer',
          style: TextStyle(
              fontFamily: 'Quicksand', fontSize: 30.0, color: Colors.white),
        ),
        Text(
          '$timing',
          style: TextStyle(
              fontFamily: 'Quicksand', fontSize: 30.0, color: Colors.white),
        ),
      ],
    );
  }
}
