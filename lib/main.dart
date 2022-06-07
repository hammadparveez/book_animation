import 'dart:math';

import 'package:book_app/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/timeline_tween/prop.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'ext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  TimelineTween<Prop> createTween() {
    final tween = TimelineTween<Prop>();
    tween
        .addScene(
          begin: const Duration(seconds: 0),
          duration: Duration(seconds: 3),
        )
        .animate(Prop.y, tween: Tween(end: 0.0, begin: 90))
        //Prop.i for Prespective View
        .animate(Prop.i, tween: Tween(end: 0.0, begin: -0.001))
        .animate(
          Prop.opacity,
          tween: Tween(begin: 1.0, end: 0.0),
          shiftBegin: const Duration(milliseconds: 0),
          shiftEnd: const Duration(milliseconds: 500),
        );
    return tween;
  }

  @override
  Widget build(BuildContext context) {
    final tween = createTween();
    return Scaffold(
      body: SafeArea(
        child: Hero(
            tag: 'book',
            flightShuttleBuilder: (_, anim, flight, ctx1, ctx2) {
              return Material(
                child: Stack(
                  children: [
                    PlayAnimation<TimelineValue<Prop>>(
                        tween: tween,
                        duration: tween.duration,
                        builder: (context, child, prop) {
                          return Opacity(
                            opacity: prop.get(Prop.opacity),
                            child: const BookPageWidget(),
                          );
                        }),
                    PlayAnimation<TimelineValue<Prop>>(
                        tween: tween,
                        duration: tween.duration,
                        builder: (context, child, prop) {
                          return Container(
                            transform: Matrix4.identity()
                              ..setEntry(3, 0, prop.get(Prop.i))
                              ..rotateY((pi / 180) * prop.get(Prop.y)),
                            child: BookCoverWidget(
                                // MediaQuery.of(ctx2).size.height;

                                ),
                          );
                        }),
                  ],
                ),
              );
            },
            child: const BookCoverWidget()),
      ),
    );
  }
}

class BookCoverWidget extends StatelessWidget {
  const BookCoverWidget({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, animation, animation2) => SecondScreen(),
            transitionsBuilder: (_, anim1, anim2, child) => child,
            transitionDuration: const Duration(seconds: 3),
            reverseTransitionDuration: const Duration(seconds: 3),
          ),
        );
      },
      child: Container(
        height: height ?? context.height,
        width: width ?? context.width,
        child: Image.asset('assets/book-cover.png', fit: BoxFit.fill),
      ),
    );
  }
}
