import 'dart:math';

import 'package:flutter/material.dart';

class Athkar extends StatefulWidget {
  const Athkar({Key? key}) : super(key: key);

  @override
  State<Athkar> createState() => _AthkarState();
}

List<String> duaa = [
  'اللهم إني أعوذ بك من زوال نعمتك، وتحول عافيتك، وفجاءة نقمتك، وجميع سخطك',
  'اللهم إني أعوذ بك من شر ما عملت، ومن شر ما لم أعمل',
  'اللهم رحمتك أرجو فلا تكلني إلى نفسي طرفة عين، وأصلح لي شأني كله، لا إله إلا أنت',
  'لا إله إلا أنت سبحانك إني كنت من الظالمين',
  'يا مقلب القلوب ثبت قلبي على دينك',
  'اللهم إني أسألك العافية في الدنيا والآخرة',
  'اللهم أحسن عاقبتنا في الأمور كلها، وأجرنا من خزي الدنيا وعذاب الآخرة',
  'اللهم إني أعوذ بك من العجز والكسل، والجبن والهرم والبخل، وأعوذ بك من عذاب القبر، ومن فتنة المحيا والممات',
  'اللهم إني أعوذ بك من جهد البلاء، ودرك الشقاء، وسوء القضاء، وشماتة الأعداء',
  'اللهم أصلح لي ديني الذي هو عصمة أمري، وأصلح لي دنياي التي فيها معاشي، وأصلح لي آخرتي التي فيها معادي، واجعل الحياة زيادة لي في كل خير، واجعل الموت راحة لي من كل شر',
  'اللهم إني أسألك الهدى، والتقى،والعفاف، والغنى'
];
int random = 1;
var kTextFont =
    TextStyle(fontFamily: 'Arabic', fontSize: 31.0, color: Colors.white);

class _AthkarState extends State<Athkar> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        setState(() {
          random = Random().nextInt(11);
          _controller = AnimationController(
            duration: const Duration(seconds: 1),
            vsync: this,
          );
          _animation =
              CurvedAnimation(parent: _controller, curve: Curves.easeIn);
          _controller.forward();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/beautiful-milky-way-night-sky.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 150),
              child: Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: Text(
                    duaa[random],
                    textAlign: TextAlign.center,
                    style: kTextFont,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
