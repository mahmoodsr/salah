import 'package:calender_picker/calender_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';

class DataPrayer extends ChangeNotifier {
  late List<String> prayers = ['', '', '', '', '', ''];
  double? longitude;
  double? latitude;

  var datex = DateTime.now();
  var datetime;
  var month;
  var year;
  var monthName;

  Future getData() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    longitude = position.longitude;
    latitude = position.latitude;
    month = DateTime.now().month;
    year = DateTime.now().year;
    monthName = DateFormat('yMMMd')
        .format(DateTime(datex.year, datex.month, datex.day));
    datetime = DateFormat.jm().format(DateTime.now());
    notifyListeners();

    monthName = DateFormat('yMMMd')
        .format(DateTime(datex.year, datex.month, datex.day));

    var urlx = Uri.parse(
        'http://api.aladhan.com/v1/calendar?latitude=$latitude&longitude=$longitude&method=4&month=$month&year=$year');
    http.Response response = await http.get(urlx);
    var datax = response.body;

    var decodedData = jsonDecode(datax);

    prayers[0] = decodedData['data'][datex.day - 1]['timings']['Fajr'];

    prayers[1] = decodedData['data'][datex.day - 1]['timings']['Sunrise'];

    prayers[2] = decodedData['data'][datex.day - 1]['timings']['Dhuhr'];

    prayers[3] = decodedData['data'][datex.day - 1]['timings']['Asr'];

    prayers[4] = decodedData['data'][datex.day - 1]['timings']['Maghrib'];

    prayers[5] = decodedData['data'][datex.day - 1]['timings']['Isha'];

    notifyListeners();
  }

  void onDateChanged(DateTime date) async {
    month = date.month;
    year = date.year;
    monthName =
        DateFormat('yMMMd').format(DateTime(date.year, date.month, date.day));
    var urlx = Uri.parse(
        'http://api.aladhan.com/v1/calendar?latitude=$latitude&longitude=$longitude&method=4&month=$month&year=$year');
    http.Response response = await http.get(urlx);
    var datax = response.body;
    var decodedData = jsonDecode(datax);
    prayers[0] = decodedData['data'][date.day - 1]['timings']['Fajr'];
    prayers[1] = decodedData['data'][date.day - 1]['timings']['Sunrise'];
    prayers[2] = decodedData['data'][date.day - 1]['timings']['Dhuhr'];
    prayers[3] = decodedData['data'][date.day - 1]['timings']['Asr'];
    prayers[4] = decodedData['data'][date.day - 1]['timings']['Maghrib'];
    prayers[5] = decodedData['data'][date.day - 1]['timings']['Isha'];
    notifyListeners();
  }

  test(String time) {
    String split = time;
    var splitted = split.split(' ');
    String index0 = splitted[0];
    return index0;
  }

  DateTime hoursCompared(String time) {
    String split = time;
    String toYear = DateTime.now().year.toString();
    String toMonth = DateTime.now().month.toString();
    String toDay = DateTime.now().day.toString();
    var splitted = split.split(' ');
    String index0 = splitted[0];

    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(toYear + '-' + toMonth + '-' + toDay + ' ' + index0 + ':00');
    return tempDate;
  }

  String minsCompared(String time) {
    String split = time;

    var splitted = split.split(' ');

    var splitted2 = splitted[0].split(':');

    var lastHours = splitted2[0];
    var lastMin = splitted2[1];
    DateTime tempDate = DateFormat("hh:mm").parse(lastHours + ':' + lastMin);

    var dateFormat = DateFormat("h:mm a");
    var y = dateFormat.format(tempDate);
    var cut = y.split(" ");

    return lastMin;
  }

  String nextPrayer() {
    List<String> x = ['fajir', 'sunrise', 'duhur', 'asr', 'magrib', 'isha'];

    late String next;

    if (DateTime.now().isAfter(hoursCompared(prayers[0]))) {
      next = x[2];
    }
    if (DateTime.now().isAfter(hoursCompared(prayers[2]))) {
      next = x[3];
    }
    if (DateTime.now().isAfter(hoursCompared(prayers[3]))) {
      next = x[4];
    }
    if (DateTime.now().isAfter(hoursCompared(prayers[4]))) {
      next = x[5];
    }
    if (DateTime.now().isAfter(hoursCompared(prayers[5]))) {
      next = x[0];
    } else {
      next = x[0];
    }
    return next;
  }

  dynamic realTimeHours() {
    var flutterTime = DateFormat.jm().format(DateTime.now());

    DateTime tempDate = DateFormat("hh:mm").parse(
        DateTime.now().hour.toString() +
            ':' +
            DateTime.now().minute.toString());
    var dateFormat = DateFormat("h:mm a");
    var compared = dateFormat.format(tempDate);
    var split = flutterTime.split(':');

    var hoursTocompare = split[0];
    return DateTime.now().hour.toString();
  }

  dynamic realTimeMin() {
    var flutterTime = DateFormat.jm().format(DateTime.now());

    DateTime tempDate = DateFormat("hh:mm").parse(
        DateTime.now().hour.toString() +
            ':' +
            DateTime.now().minute.toString());
    var dateFormat = DateFormat("h:mm a");
    var compared = dateFormat.format(tempDate);
    var split = flutterTime.split(':');
    var hoursTocompare = split[0];
    var a = split[1].split(" ");
    var w = a[0];
    return DateTime.now().minute.toString();
  }
}
