import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFFEEEEEE),
      title: 'Flutter Demo',
      builder: (BuildContext context, Widget widget) {
        return widget;
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return PageRouteBuilder<Widget>(pageBuilder: (BuildContext context,
                Animation<double> pAnimation, Animation<double> sAnimation) {
              return StoriesScreen();
            });
          default:
            return PageRouteBuilder<Widget>(pageBuilder: (BuildContext context,
                Animation<double> pAnimation, Animation<double> sAnimation) {
              return StoriesScreen();
            });
        }
      },
    );
  }
}

class StoriesScreen extends StatefulWidget {
  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  double progress = 0;
  double start = 0;

  double dragProgress = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        start = (details.localPosition / MediaQuery.of(context).size.width).dx;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        progress =
            (details.localPosition / MediaQuery.of(context).size.width).dx;

        setState(() {
          dragProgress = (progress - start) * -1;
        });
      },
      onHorizontalDragEnd: (DragEndDetails details) {
//        setState(() {
//          dragProgress = 0;
//        });
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(dragProgress * math.pi / 2)
                ..translate(dragProgress * -MediaQuery.of(context).size.width),
              origin: Offset(
                  (MediaQuery.of(context).size.width / 2) -
                      (MediaQuery.of(context).size.width / 2 * dragProgress),
                  MediaQuery.of(context).size.height / 2),
              child: Container(
                child: Image.network(
                  'https://placeimg.com/480/720/arch',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
//          Positioned.fill(
//            child: Transform(
//              transform: Matrix4.identity()
//                ..setEntry(3, 2, 0.001)
//                ..rotateY(dragProgress * math.pi / 2),
////                ..translate(dragProgress * -MediaQuery.of(context).size.width),
//              origin: Offset(MediaQuery.of(context).size.width / 2,
//                  MediaQuery.of(context).size.height / 2),
//              child: Container(
//                color: Colors.amber,
//                child: Image.network(
//                  'https://placeimg.com/480/720/arch',
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
