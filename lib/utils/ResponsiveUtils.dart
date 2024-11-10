import 'package:flutter/material.dart';

class ResponsiveUtils {

  static double scrWidth = 600;
  static double scrHeight = 600;

  static calcScrWidth(BuildContext context){
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    print('scrWidth=$scrWidth, scrHeight=$scrHeight');

    var ca = (ResponsiveUtils.scrWidth/225);
    int cac = (ResponsiveUtils.scrWidth/225).round();
    print('ca=$ca, cac=$cac');
  }

  double getPercentage(double num, double perc){
    return (num * perc) / 100;
  }

  double incByPercentage(double pNum, double pPerc){
    var perc = getPercentage(pNum, pPerc);
    double finalNum = pNum + perc;
    print('pNum=$pNum,pPerc=$pPerc || perc=$perc, finalNum=$finalNum');

    return finalNum;
  }

  static double getScrWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  // Check if the device is considered as mobile based on screen width.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

  // Check if the device is considered as tablet based on screen width.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 600 &&
          MediaQuery.of(context).size.width <= 1200;

  // Check if the device is considered as desktop based on screen width.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;
}