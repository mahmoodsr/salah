import 'package:flutter/material.dart';
import 'package:widget_loading/widget_loading.dart';
import 'package:geolocator/geolocator.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'DataPrayer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () async {
          await Provider.of<DataPrayer>(context).getData();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: Scaffold(
          backgroundColor: Color(0xff484747),
          body: Center(
              child: CircularWidgetLoading(
                  dotColor: Colors.white, loading: true, child: Container())),
        ));
  }
}

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
