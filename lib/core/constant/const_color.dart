import 'package:flutter/painting.dart';

enum ConstColor {
  mainLight(Color(0xff703EFF)),
  primary(Color(0xffA4CFC3)),
  icon(Color(0xff9CA3AF)),
  text(Color(0xff767c8c)), // 767c8c

  blue(Color(0xff0c8ce9)),
  iconDark(Color(0xff393939)), // 27292d, secondary c3a3f8
  dark(Color(0xff2e2e2e)),
  white(Color(0xffffffff)),
  secondary(Color(0xfff8f9fe));

  // mainLight, mainDark => heavy background
  // secLight, secDark => light color
  // textLight, textDark => text color

  final Color color;
  const ConstColor(this.color);
}

const Gradient greenToTealGradient = LinearGradient(
  colors: [
    Color(0xFF66BB6A), // Medium Green
    Color(0xFF26A69A), // Teal
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Gradient tealToBlueGradient = LinearGradient(
  colors: [
    Color(0xFF1DE9B6), // Teal
    Color(0xFF1E88E5), // Blue
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const Gradient orangeToRedGradient = LinearGradient(
  colors: [
    Color(0xFFFFA726), // Orange
    Color(0xFFEF5350), // Red
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Gradient blueToPurpleGradient = LinearGradient(
  colors: [
    Color(0xFF42A5F5), // Light Blue
    Color(0xFF7B1FA2), // Deep Purple
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
