import 'dart:math';

import 'package:book_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_animations/simple_animations.dart';
import 'ext.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  TimelineTween<Prop> createTween() {
    final tween = TimelineTween<Prop>();
    tween
        .addScene(
          begin: const Duration(seconds: 0),
          duration: Duration(seconds: 3),
        )
        .animate(Prop.y, tween: Tween(begin: 0.0, end: 90))
        //Prop.i for Prespective View
        .animate(Prop.i, tween: Tween(begin: 0.0, end: -0.001))
        .animate(Prop.opacity,
            tween: Tween(begin: 0.0, end: 1.0),
            shiftBegin: Duration(milliseconds: 1500));
    return tween;
  }

  @override
  Widget build(BuildContext context) {
    final tween = createTween();
    return Hero(
      tag: 'book',
      flightShuttleBuilder: (context, anim, flight, ctx1, ctx2) {
        return Material(
          child: Stack(
            children: [
              PlayAnimation<TimelineValue<Prop>>(
                  tween: tween,
                  duration: tween.duration,
                  builder: (context, child, prop) {
                    return Opacity(
                      opacity: prop.get(Prop.opacity),
                      child: Container(
                        transform: Matrix4.identity(),
                        child: BookPageWidget(
                          height: ctx2.height,
                          width: context.width,
                        ),
                      ),
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
                      child: BookCoverWidget(),
                    );
                  }),
            ],
          ),
        );
      },
      child: Scaffold(
        body: BookPageWidget(),
      ),
    );
  }
}

class BookPageWidget extends StatelessWidget {
  const BookPageWidget({Key? key, this.width, this.height}) : super(key: key);
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(),
      height: height,
      width: width,
      child: Wrap(
        children: [
          Text("Whati s Loreium Ipsum?", style: TextStyle(fontSize: 23)),
          Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.\n\n"),
          Text("Whati s Loreium Ipsum?", style: TextStyle(fontSize: 23)),
          Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.\n\n"),
          Text("Whati s Loreium Ipsum?", style: TextStyle(fontSize: 23)),
          Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.\n\n"),
          Text("Whati s Loreium Ipsum?", style: TextStyle(fontSize: 23)),
          Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.\n\n"),
          BackButton(),
        ],
      ),
    );
  }
}
