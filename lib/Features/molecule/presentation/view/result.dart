// ignore_for_file: camel_case_types

import 'package:Toxicon/core/constants/colorconstant.dart';
import 'package:Toxicon/core/utils/function/moreunfo.dart';
import 'package:Toxicon/core/utils/function/resultcontainer.dart';
import 'package:Toxicon/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class resultmolecule extends StatelessWidget {
  resultmolecule(
      {super.key,
      required this.size,
      required this.result,
      required this.isDark,
      required this.bond,
      required this.atom,
      required this.gester,
      required this.sascore,
      required this.toxscore,
      required this.imagepath});

  final Size size;
  final bool result;
  String bond;
  final bool isDark;
  String imagepath;
  String atom;
  String gester;
  double toxscore;
  double sascore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfont24_600(text: 'Result'),
        SizedBox(height: size.height * .024),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: result,
              text: 'Toxic',
            ),
            resultwidgetcontainer(
              size: size,
              isDark: isDark,
              result: !result,
              text: 'Non-Toxic',
            ),
          ],
        ),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
              
                 
SizedBox(
  width: 180,
  height: 210,
  child:   SfRadialGauge(
  
      axes: <RadialAxis>[
  
        RadialAxis(minimum: -100,
  
            maximum: 100,
  
            startAngle:270,
  
            endAngle: 270,
  
            showLabels: false,
  
            showTicks: false,
  
            radiusFactor: 0.6,
  
            axisLineStyle:const AxisLineStyle(
  
                cornerStyle: CornerStyle.bothFlat,
  
                color: Colors.black12,
  
                thickness: 12),
  
            pointers: <GaugePointer>[
  
              RangePointer(
                  value: toxscore,
  
                  cornerStyle: CornerStyle.bothFlat,
  
                  width: 12,
  
                  sizeUnit: GaugeSizeUnit.logicalPixel,
  
                  color:  icolor,
  
                 ),
  
              MarkerPointer(
  
                  value: toxscore,
  
                  enableDragging: true,
  
  
                  markerHeight: 20,
  
                  markerWidth: 20,
  
                  markerType: MarkerType.circle,
  
                  color: icolor  ,
  
                  borderWidth: 2,
  
                  borderColor: Colors.white54)
  
            ],
  
        )
  
      ]
  
  ),
),
                Text('$toxscore',style: Styles.textStyle16,),
                SizedBox(height: size.height * .02),
                CustomTextfont24_600(text: 'Tox score')
              ],
            ),
            Column(
              children: [
                SizedBox(
  width:180,
  height: 210,
  child:   SfRadialGauge(
  
      axes: <RadialAxis>[
  
        RadialAxis(minimum: -100,
  
            maximum: 100,
  
            startAngle: 0,
  
            endAngle: 360,
  
            showLabels: false,
  
            showTicks: false,
  
            radiusFactor: 0.6,
  
            axisLineStyle:const AxisLineStyle(
  
                cornerStyle: CornerStyle.bothFlat,
  
                color: Colors.black12,
  
                thickness: 12),
  
            pointers: <GaugePointer>[
  
              RangePointer(
  
                  value: sascore,
  
                  cornerStyle: CornerStyle.bothFlat,
  
                  width: 12,
  
                  sizeUnit: GaugeSizeUnit.logicalPixel,
  
                  color:  seccolor,
  
                 ),
  
              MarkerPointer(
  
                  value: sascore,
  
                  enableDragging: true,
  
                 
  
                  markerHeight: 20,
  
                  markerWidth: 20,
  
                  markerType: MarkerType.circle,
  
                  color: seccolor ,
  
                  borderWidth: 2,
  
                  borderColor: Colors.white54)
  
            ],
  
        )
  
      ]
  
  ),
),
                 Text('$sascore',style:Styles.textStyle16,),
                SizedBox(height: size.height * .02),
                CustomTextfont24_600(text: 'SA score')
              ],
            )
          ],
        ),
        SizedBox(height: size.height * .04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextfont24_600(text: 'More Info'),
            morinformation(
              gester: gester,
              atom: atom,
              size: size,
              isDark: isDark,
              bond: bond,
              imagepath: imagepath,
            )
          ],
        ),
        SizedBox(height: size.height * .04),
      ],
    );
  }
}
