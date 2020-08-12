import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rotating_figures/utils/point_3D.dart';
import 'package:zflutter/zflutter.dart';
import 'way.dart';


class Shapes {

  final Point3D Q = Point3D (0, 0, 0);
  final Point3D O = Point3D (0, 0, 0);



  List <ZShape> quadrilateralSides ( double a, double b ){
    List <ZShape> planes = [];
    ZShape plane = ZShape(path: [
      ZMove.only(x: Q.x, y: Q.y, z: Q.z),
      ZLine.only(x: Q.x, y: Q.y+a, z: Q.z),
      ZLine.only(x: Q.x+b, y: Q.y+a, z: Q.z),
      ZLine.only(x: Q.x+b, y: Q.y, z: Q.z),
    ], closed: true, stroke: 1, fill: true, color: Colors.blue);
    planes.add(plane);
    return planes;
  }

  List <ZShape> quadrilateralPoints ( Point3D A, Point3D B, Point3D C, Point3D D, {bool filling = false,
    double scenario = 0,
    //double up = 0, double right = 0, double forward = 0, double radius = 0
    Way w,
    Point3D med,
    double axisX = 0,
    double axisY = 0,
    double axisZ = 0,
    bool rotation = false,
    Color color = Colors.black,
    double thick = 1,
    ZVector translate,

    }){

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    //(scenario - 1 + w.coef) / (w.coef) ;

    double X = right * scenario - (radius - radius * cos(2 * pi * scenario * w.coef));
    double Y = - up * pow(sin(pow(scenario * 1.8, 4)), 2) - radius * sin(2 * pi * scenario * w.coef);
    double Z = forward * scenario;

    med = med ?? Point3D((A.x + B.x + C.x + D.x) / 4, (A.y + B.y + C.y + D.y) / 4, (A.z + B.z + C.z + D.z) / 4);
    translate = translate ?? ZVector.zero;

    double medX = X + med.x;
    double medY = Y + med.y;
    double medZ = Z + med.z;

    if (rotation) {
      axisX = scenario * axisX * 2 * pi / 360;
      axisY = scenario * axisY * 2 * pi / 360;
      axisZ = scenario * axisZ * 2 * pi / 360;
    }
    else{
      axisX = axisX * 2 * pi / 360;
      axisY = axisY * 2 * pi / 360;
      axisZ = axisZ * 2 * pi / 360;
    }

    double AX = (A.x + X) - medX;
    double BX = (B.x + X) - medX;
    double CX = (C.x + X) - medX;
    double DX = (D.x + X) - medX;
    double AY = (A.y + Y) - medY;
    double BY = (B.y + Y) - medY;
    double CY = (C.y + Y) - medY;
    double DY = (D.y + Y) - medY;
    double AZ = (A.z + Z) - medZ;
    double BZ = (B.z + Z) - medZ;
    double CZ = (C.z + Z) - medZ;
    double DZ = (D.z + Z) - medZ;

    double OAX;
    double OBX;
    double OCX;
    double ODX;
    double OAY;
    double OBY;
    double OCY;
    double ODY;
    double OAZ;
    double OBZ;
    double OCZ;
    double ODZ;

    // X axis turn
    OAX = (AX);
    OBX = (BX);
    OCX = (CX);
    ODX = (DX);

    OAY = (AY) * cos(axisX) + (AZ) * (sin(axisX));
    OBY = (BY) * cos(axisX) + (BZ) * (sin(axisX));
    OCY = (CY) * cos(axisX) + (CZ) * (sin(axisX));
    ODY = (DY) * cos(axisX) + (DZ) * (sin(axisX));

    OAZ = (AZ) * cos(axisX) - (AY) * sin(axisX);
    OBZ = (BZ) * cos(axisX) - (BY) * sin(axisX);
    OCZ = (CZ) * cos(axisX) - (CY) * sin(axisX);
    ODZ = (DZ) * cos(axisX) - (DY) * sin(axisX);

    AX = OAX;
    BX = OBX;
    CX = OCX;
    DX = ODX;
    AY = OAY;
    BY = OBY;
    CY = OCY;
    DY = ODY;
    AZ = OAZ;
    BZ = OBZ;
    CZ = OCZ;
    DZ = ODZ;

    //Y axis turn
    OAX = (AX) * cos(axisY) + (AZ) * sin(axisY);
    OBX = (BX) * cos(axisY) + (BZ) * sin(axisY);
    OCX = (CX) * cos(axisY) + (CZ) * sin(axisY);
    ODX = (DX) * cos(axisY) + (DZ) * sin(axisY);

    OAY = AY;
    OBY = BY;
    OCY = CY;
    ODY = DY;

    OAZ = (AZ) * cos(axisY) - (AX) * sin(axisY);
    OBZ = (BZ) * cos(axisY) - (BX) * sin(axisY);
    OCZ = (CZ) * cos(axisY) - (CX) * sin(axisY);
    ODZ = (DZ) * cos(axisY) - (DX) * sin(axisY);

    AX = OAX;
    BX = OBX;
    CX = OCX;
    DX = ODX;
    AY = OAY;
    BY = OBY;
    CY = OCY;
    DY = ODY;
    AZ = OAZ;
    BZ = OBZ;
    CZ = OCZ;
    DZ = ODZ;

    //Z axis turn
    OAX = (AX) * cos(axisZ) - (AY) * sin(axisZ);
    OBX = (BX) * cos(axisZ) - (BY) * sin(axisZ);
    OCX = (CX) * cos(axisZ) - (CY) * sin(axisZ);
    ODX = (DX) * cos(axisZ) - (DY) * sin(axisZ);

    OAY = (AY) * cos(axisZ) + (AX) * sin(axisZ);
    OBY = (BY) * cos(axisZ) + (BX) * sin(axisZ);
    OCY = (CY) * cos(axisZ) + (CX) * sin(axisZ);
    ODY = (DY) * cos(axisZ) + (DX) * sin(axisZ);

    OAZ = AZ;
    OBZ = BZ;
    OCZ = CZ;
    ODZ = DZ;

    AX = OAX;
    BX = OBX;
    CX = OCX;
    DX = ODX;
    AY = OAY;
    BY = OBY;
    CY = OCY;
    DY = ODY;
    AZ = OAZ;
    BZ = OBZ;
    CZ = OCZ;
    DZ = ODZ;

    List <ZShape> planes = [];
    ZShape plane = ZShape(path: [
      ZMove.only(x: AX + medX + translate.x, y: AY + medY - translate.y, z: AZ + medZ - translate.z ),
      ZLine.only(x: BX + medX + translate.x, y: BY + medY - translate.y, z: BZ + medZ - translate.z ),
      ZLine.only(x: CX + medX + translate.x, y: CY + medY - translate.y, z: CZ + medZ - translate.z ),
      ZLine.only(x: DX + medX + translate.x, y: DY + medY - translate.y, z: DZ + medZ - translate.z ),
    ], closed: true, stroke: thick, fill: filling, color: color);
    planes.add(plane);
    return planes;
  }

  List <ZShape> parallelepipedSides( Point3D O, { double a = 10, double b = 10, double c = 10,
    double scenario = 0,
    Way w,
    //double up = 0, double right = 0, double forward = 0, double radius = 0,
    double axisX = 0, double axisY = 0, double axisZ = 0 } ){

    List <ZShape> carcasses = [];

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    double X = O.x + right * scenario - (radius - radius * cos(2 * pi * scenario));
    double Y = O.y - up * scenario - radius * sin(2 * pi * scenario);
    double Z = O.z + forward * scenario;


    ZShape carcass = ZShape(path: [

      ZMove.only(x: (X), y: Y, z: Z),
      ZLine.only(x: (X), y: Y+b, z: Z),
      ZLine.only(x: (X+a), y: Y+b, z: Z),
      ZLine.only(x: (X+a), y: Y, z: Z),
      ZLine.only(x: (X), y: Y, z: Z),

      ZMove.only(x: (X), y: Y, z: Z+c),
      ZLine.only(x: (X), y: Y+b, z: Z+c),
      ZLine.only(x: (X+a), y: Y+b, z: Z+c),
      ZLine.only(x: (X+a), y: Y, z: Z+c),
      ZLine.only(x: (X), y: Y, z: Z+c),

      ZMove.only(x: (X), y: Y, z: Z+c),
      ZLine.only(x: (X), y: Y, z: Z),

      ZMove.only(x: (X), y: Y+b, z: Z+c),
      ZLine.only(x: (X), y: Y+b, z: Z),

      ZMove.only(x: (X+a), y: Y+b, z: Z+c),
      ZLine.only(x: (X+a), y: Y+b, z: Z),

      ZMove.only(x: (X+a), y: Y, z: Z+c),
      ZLine.only(x: (X+a), y: Y, z: Z),

    ], closed: false, stroke: 1, fill: false, color: Colors.blue);
    carcasses.add(carcass);
    return carcasses;
  }

//  Point3D placeOfParallelepiped ( Point3D O,
//      { double a = 10, double b = 10, double c = 10,
//        double scenario = 0,
//        Way w,
//        double axisX = 0, double axisY = 0, double axisZ = 0} ){
//
//  }

  List <ZShape> parallelepipedFull ( Point3D O, { double a = 10, double b = 10, double c = 10,
    double scenario = 0,
    //double up = 0, double right = 0, double forward = 0, double radius = 0
    Way w,
    double axisX = 0, double axisY = 0, double axisZ = 0,
    bool filling = true,
    Color color = Colors.black,
    double thick = 1,
    ZVector translate,
    } ){

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    Point3D med = Point3D( O.x, O.y, O.z);

    double X = O.x;
    double Y = O.y;
    double Z = O.z;



    List <ZShape> parallelepiped = [];

    Point3D A1 = Point3D(X - a / 2, Y - b / 2, Z + c / 2);
    Point3D B1 = Point3D(X - a / 2, Y + b / 2, Z + c / 2);
    Point3D C1 = Point3D(X + a / 2, Y + b / 2, Z + c / 2);
    Point3D D1 = Point3D(X + a / 2, Y - b / 2, Z + c / 2);

    Point3D A2 = Point3D(X - a / 2, Y - b / 2, Z - c / 2);
    Point3D B2 = Point3D(X - a / 2, Y + b / 2, Z - c / 2);
    Point3D C2 = Point3D(X + a / 2, Y + b / 2, Z - c / 2);
    Point3D D2 = Point3D(X + a / 2, Y - b / 2, Z - c / 2);



    parallelepiped.addAll(quadrilateralPoints( A1, B1, C1, D1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    parallelepiped.addAll(quadrilateralPoints( A1, B1, B2, A2, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    parallelepiped.addAll(quadrilateralPoints( A2, B2, C2, D2, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    parallelepiped.addAll(quadrilateralPoints( C2, D2, D1, C1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    parallelepiped.addAll(quadrilateralPoints( C2, B2, B1, C1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    parallelepiped.addAll(quadrilateralPoints( A2, D2, D1, A1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));

    return ( parallelepiped );
  }

  List <ZShape> tetrahedronFull ( Point3D O,
    { double a = 10,
    double scenario = 0,
    Way w,
    double axisX = 0, double axisY = 0, double axisZ = 0,
    bool filling = true,
    Color color = Colors.black,
    double thick = 1,
    ZVector translate,
    } ){

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    Point3D med = Point3D(O.x, O.y, O.z);
    translate = translate ?? ZVector.zero;

    double X = O.x;
    double Y = O.y + a * 2 * sqrt(2 / 3) / 3;
    double Z = O.z;



    List <ZShape> tetrahedron = [];

    Point3D A1 = Point3D(X, Y, Z);
    Point3D B1 = Point3D(X - a / 2, Y - a * sqrt(2 / 3), Z + a * sqrt(3) / 6);
    Point3D C1 = Point3D(X + a / 2, Y - a * sqrt(2 / 3), Z + a * sqrt(3) / 6);
    Point3D D1 = Point3D(X        , Y - a * sqrt(2 / 3), Z - a * sqrt(3) / 3);

    tetrahedron.addAll(quadrilateralPoints( A1, B1, C1, A1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( A1, B1, D1, A1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( A1, C1, D1, A1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( B1, D1, C1, B1, filling: filling, color: color, thick: thick, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    return ( tetrahedron );
  }

  List <ZShape> tetrahedronFullBlackWhite ( Point3D O,
      { double a = 10,
        double scenario = 0,
        Way w,
        double axisX = 0, double axisY = 0, double axisZ = 0,
        bool filling = true,
        Color color = Colors.black,
        double thick = 1,
        ZVector translate,
      } ){

    double right = w.right;
    double forward = w.forward;
    double up = w.up;
    double radius = w.radius;

    Point3D med = Point3D(O.x, O.y, O.z);
    translate = translate ?? ZVector.zero;

    double X = O.x;
    double Y = O.y + a * 2 * sqrt(2 / 3) / 3;
    double Z = O.z;



    List <ZShape> tetrahedron = [];

    Point3D A1 = Point3D(X, Y, Z);
    Point3D B1 = Point3D(X - a / 2, Y - a * sqrt(2 / 3), Z + a * sqrt(3) / 6);
    Point3D C1 = Point3D(X + a / 2, Y - a * sqrt(2 / 3), Z + a * sqrt(3) / 6);
    Point3D D1 = Point3D(X        , Y - a * sqrt(2 / 3), Z - a * sqrt(3) / 3);

    tetrahedron.addAll(quadrilateralPoints( A1, B1, C1, A1, filling: true, color: Colors.white, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( A1, B1, D1, A1, filling: true, color: Colors.white, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( A1, C1, D1, A1, filling: true, color: Colors.white, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( B1, D1, C1, B1, filling: true, color: Colors.white, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));

    tetrahedron.addAll(quadrilateralPoints( A1, B1, C1, A1, filling: false, color: Colors.black, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( A1, B1, D1, A1, filling: false, color: Colors.black, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( A1, C1, D1, A1, filling: false, color: Colors.black, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    tetrahedron.addAll(quadrilateralPoints( B1, D1, C1, B1, filling: false, color: Colors.black, thick: 1, scenario: scenario , w: w, med: med, axisX: axisX, axisY: axisY, axisZ: axisZ, rotation: true, translate: translate ));
    return ( tetrahedron );
  }

}
