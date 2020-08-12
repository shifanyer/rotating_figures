import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rotating_figures/utils/shapes.dart';
import 'package:rotating_figures/utils/way.dart';
import 'package:zflutter/zflutter.dart';
import 'point_3D.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

class PageRenderer extends StatefulWidget {
  @override
  _PageRendererState createState() => _PageRendererState();
}

double lightRadiusValue = 300.0;
//List<double> translateValues = [0.0, 0.0];

class _PageRendererState extends State<PageRenderer>
    with SingleTickerProviderStateMixin {
  List<List<Point3D>> circle = [];
  List<List<Point3D>> circleStroke = [];
  List<bool> toggleOptions = [false, false];
  List shapeList = [];

//  print ('$ {parsedJson.runtimeType}: $ parsedJson');

  Point3D A;
  Point3D B;
  Point3D C;
  Point3D D;
  Point3D strokeA;
  Point3D strokeB;
  Point3D strokeC;
  Point3D strokeD;
  Point3D I;
  Point3D I2;
  Point3D I3;
  Point3D I22;
  Point3D ps;
  Point3D ps1;
  Point3D ps2;
  Point3D center;
  Point3D center1;
  Point3D center2;
  Point3D A2;
  double radius;
  Way way1;
  List<Way> choreographer = [];

  List<List<ZShape>> objects = [];
  Map scores;

  double zoomValue = 0.5;
  double zoomSliderValue = 0.0;
  double lightRadiusSliderValue = 0.0;

  List<ZShape> temporaryList = [];

  @override
  void initState() {
    //var scores = jsonDecode("../../../assets/ways/choreograph.json");

    // Creating base Points
    plane();
    // Adding Objects on screen
    initShape();

    super.initState();
  }

  plane() async {
    A = Point3D(50, 50, 0);
    B = Point3D(-100, 50, 0);
    C = Point3D(-100, -150, 0);
    D = Point3D(50, -150, 0);

    I = Point3D(0, 250, 0);
    I2 = Point3D(350, 180, 0);
    I3 = Point3D(-350, 180, 0);
    I22 = Point3D(0, 0, -200);
    A2 = Point3D(50, 50, 50);

    radius = 40;
    ps = Point3D(40, 0, 0);
    center = Point3D(0, 0, 0);
    ps1 = Point3D(-50, -40, 0);
    ps2 = Point3D(50, 40, 0);
    center1 = Point3D(-50, 0, 0);
    center2 = Point3D(130, 0, 0);

    choreographer
        .add(Way(up: 300, right: -100, forward: 0, radius: 10, coef: 1));
    choreographer.add(Way(up: 250, right: 200, forward: 0, radius: 0, coef: 1));
    choreographer
        .add(Way(up: -150, right: 300, forward: 0, radius: 10, coef: 1));
    choreographer.add(Way(up: 300, right: 0, forward: 0, radius: 350, coef: 2));
    choreographer.add(Way(up: 300, right: 0, forward: 0, radius: -350, coef: 3));
    choreographer.add(Way(up: 450, right: 0, forward: 0, radius: 0, coef: 1));
    choreographer.add(Way(up: 0, right: 0, forward: 0, radius: 0, coef: 1));
  }

  initShape() {}

//  final animation = Tween(begin: 0, end: 1).animate(controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: Colors.cyan,
          child: Stack(children: [
            ZDragDetector(builder: (context, controller) {
              return ZIllustration(zoom: 1, children: [
                ZPositioned(
                    rotate: ZVector.only(
                        x: controller.rotate.x, y: controller.rotate.y),
                    child: ZGroup(children: [...shapeList]))
              ]);
            }),
            SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: ZDragDetector(builder: (context, controller) {
                  return ZIllustration(zoom: 1, children: [
                    ZPositioned(
                        rotate: ZVector.only(
                            x: controller.rotate.x, y: controller.rotate.y),
                        child: ZGroup(children: [
                          for (dynamic shape in temporaryList) shape
                        ]))
                  ]);
                })),
            Positioned(
                bottom: 20,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child:
//    AnimatedBuilder(builder: (BuildContext context, Widget child) {
//                          return ();
//                        }, animation: animation,)

                            Column(children: [
                              SliderTheme(
                                data: SliderThemeData(trackHeight: 6),
                                child: Slider(
                                  activeColor: Colors.greenAccent,
                                  inactiveColor: Colors.lightGreenAccent,
                                  value: zoomSliderValue,
                                  onChanged: (value) {
                                    setState(() {
                                      shapeList.clear();

                                      way1 = choreographer[0];
                                      shapeList
                                          .addAll(Shapes().tetrahedronFullBlackWhite(I,
                                          a: 800,
                                          scenario: value,
                                          w: choreographer[5],
                                          axisX: 990,
                                          //axisY: 40,
                                          axisY: 1440,
//                                          axisX: 0,
//                                          axisY: 0,

                                          filling: true,
                                          color: Colors.white,
                                          translate: ZVector(0, 0, 0)));
                                      /*
                                      shapeList
                                          .addAll(Shapes().tetrahedronFull(I,
                                              a: 500,
                                              scenario: value,
                                              w: choreographer[5],
                                              axisX: 900,
                                              //axisY: 40,
                                              axisY: 1680,
                                              filling: false,
                                              color: Colors.black,
                                              thick: 4,
                                              translate: ZVector(0, 0, 0)));

                                      shapeList
                                          .addAll(Shapes().tetrahedronFull(I,
                                              a: 500,
                                              scenario: value,
                                              w: choreographer[5],
                                              axisX: 900,
                                              //axisY: 40,
                                              axisY: 1680,
                                              filling: true,
                                              color: Colors.white,
                                              translate: ZVector(0, 0, 0)));
                                      */

                                      shapeList
                                          .addAll(Shapes().tetrahedronFullBlackWhite(I2,
                                          a: 200,
                                          scenario: value,
                                          w: choreographer[3],
                                          axisX: 900,
                                          //axisY: 40,
                                          axisY: 1680,
                                          axisZ: 720,
                                          filling: true,
                                          color: Colors.white,
                                          translate: ZVector(0, 0, 0)));

                                      /*
                                      shapeList
                                          .addAll(Shapes().tetrahedronFull(I2,
                                          a: 200,
                                          scenario: value,
                                          w: choreographer[3],
                                          axisX: 900,
                                          //axisY: 40,
                                          axisY: 1680,
                                          axisZ: 720,
                                          filling: false,
                                          color: Colors.black,
                                          thick: 4,
                                          translate: ZVector(0, 0, 0)));

                                      shapeList
                                          .addAll(Shapes().tetrahedronFull(I2,
                                          a: 200,
                                          scenario: value,
                                          w: choreographer[3],
                                          axisX: 900,
                                          //axisY: 40,
                                          axisY: 1680,
                                          axisZ: 720,
                                          filling: true,
                                          color: Colors.white,
                                          translate: ZVector(0, 0, 0)));

                                      */

                                      shapeList
                                          .addAll(Shapes().tetrahedronFullBlackWhite(I3,
                                          a: 200,
                                          scenario: value,
                                          w: choreographer[4],
                                          axisX: 900,
                                          //axisY: 40,
                                          axisY: 1680,
                                          axisZ: 720,
                                          filling: true,
                                          color: Colors.white,
                                          translate: ZVector(0, 0, 0)));

                                      /*
                                      shapeList
                                          .addAll(Shapes().tetrahedronFull(I3,
                                          a: 200,
                                          scenario: value,
                                          w: choreographer[4],
                                          axisX: 900,
                                          //axisY: 40,
                                          axisY: 1680,
                                          axisZ: 720,
                                          filling: false,
                                          color: Colors.black,
                                          thick: 4,
                                          translate: ZVector(0, 0, 0)));

                                      shapeList
                                          .addAll(Shapes().tetrahedronFull(I3,
                                          a: 200,
                                          scenario: value,
                                          w: choreographer[4],
                                          axisX: 900,
                                          //axisY: 40,
                                          axisY: 1680,
                                          axisZ: 720,
                                          filling: true,
                                          color: Colors.white,
                                          translate: ZVector(0, 0, 0)));
                                      */
                                      /*
                                      shapeList
                                          .addAll(Shapes().parallelepipedFull(I,
                                          a: 300,
                                          b: 300,
                                          c: 300,
                                          scenario: value,
                                          w: choreographer[4],
                                          axisX: 700,
                                          axisY: 200,
                                          axisZ: 600,
                                          filling: false,
                                          color: Colors.black,
                                          thick: 4,
                                          translate: ZVector(0, 0, 0)));

                                      shapeList
                                          .addAll(Shapes().parallelepipedFull(I,
                                          a: 300,
                                          b: 300,
                                          c: 300,
                                          scenario: value,
                                          w: choreographer[4],
                                          axisX: 700,
                                          axisY: 200,
                                          axisZ: 600,
                                          filling: true,
                                          color: Colors.white,
                                          translate: ZVector(0, 0, 0)));

                                       */
//
//                                      shapeList.addAll(Shapes().tetrahedronFull(
//                                        I,
//                                        a: 50,
//                                        scenario: value,
//                                        w: choreographer[4],
//                                        //axisX: 90,
//                                        //axisY: 40,
//                                        axisX: 1200,
//                                      ));
                                      zoomSliderValue = value;
                                      zoomValue = 0.5 + value * 1.5;
                                    });
                                  })),
                               SizedBox(height: 12),
                        ]))))
          ]),
        ));
  }
}
