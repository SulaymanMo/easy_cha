import '../constant/const_color.dart';
import 'text_theme.dart';
import 'custom_borders.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(primary: ConstColor.mainLight.color),
    scaffoldBackgroundColor: ConstColor.white.color,
    // ! _____ AppBar _____ ! //
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ConstColor.dark.color,
      ),
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      backgroundColor: ConstColor.white.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(4.w),
          bottomRight: Radius.circular(4.w),
        ),
      ),
      actionsIconTheme: IconThemeData(
        size: 20.sp,
        color: ConstColor.text.color,
      ),
      iconTheme: IconThemeData(
        size: 20.sp,
        color: ConstColor.text.color,
      ),
    ),
    // ! _____ TabBar _____ ! //
    tabBarTheme: TabBarTheme(
      dividerHeight: 0.6,
      labelColor: ConstColor.dark.color,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: ConstColor.text.color,
      splashFactory: NoSplash.splashFactory,
      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 14.sp),
      labelPadding: EdgeInsets.symmetric(horizontal: 0.5.w),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      indicator: ShapeDecoration(
        shape: StadiumBorder(
          side: BorderSide(color: ConstColor.dark.color, width: .5.w),
        ),
      ),
    ),
    // ! _____ Card Theme _____ ! //
    cardTheme: CardTheme(
      elevation: .5,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      color: ConstColor.white.color,
    ),
    // ! _____ Text Theme _____ ! //
    textTheme: textTheme(),
    fontFamily: "Inter_Light",
    // ! _____ ListTile _____ ! //
    listTileTheme: ListTileThemeData(
      textColor: Colors.black54,
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      iconColor: ConstColor.mainLight.color,
      titleTextStyle: TextStyle(
        inherit: false,
        fontSize: 15.5.sp,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: TextStyle(
        inherit: false,
        fontSize: 14.sp,
      ),
    ),
    // ! _____ Icon _____ ! //
    iconTheme: IconThemeData(
      size: 20.sp,
      color: ConstColor.text.color,
    ),
    // ! _____ ElevatedButton _____ ! //
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: ConstColor.secondary.color,
        backgroundColor: ConstColor.mainLight.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
        ),
        minimumSize: Size(double.infinity, 5.5.h),
        textStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // ! _____ OutlinedButton _____ ! //
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ConstColor.iconDark.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.w),
        ),
        textStyle: TextStyle(
          inherit: false,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // ! _____ TextButton _____ ! //
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ConstColor.iconDark.color,
        textStyle: TextStyle(
          fontSize: 14.sp,
          letterSpacing: 2.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // ! _____ Icon Button _____ ! //
    // iconButtonTheme: IconButtonThemeData(
    //   style: IconButton.styleFrom(
    //     iconSize: 20.sp,
    //     foregroundColor: ConstColor.dark.color,
    //     backgroundColor: ConstColor.secondary.color,
    //   ),
    // ),
    // ! _____ Bottom App Bar _____ ! //
    bottomAppBarTheme: BottomAppBarTheme(
      height: 6.5.h,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
    ),
    // ! _____ Floating Button _____ ! //
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      highlightElevation: 0,
      shape: CircleBorder(),
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black87,
    ),
    // ! _____ Fixed Bottom Sheet _____ ! //
    bottomSheetTheme: BottomSheetThemeData(
      showDragHandle: true,
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      dragHandleColor: ConstColor.dark.color,
      backgroundColor: Colors.white,
    ),
    // ! _____ Vertical & Horizontal Divider Theme _____ ! //
    dividerTheme: DividerThemeData(
      space: 2.h,
      color: ConstColor.icon.color,
    ),
    // ! _____ Dialog Theme _____ ! //
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.w),
          topRight: Radius.circular(4.w),
        ),
      ),
      backgroundColor: ConstColor.secondary.color,
    ),
    // ! _____ Switch Theme _____ ! //
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (state) {
          if (state.contains(WidgetState.selected)) {
            return ConstColor.dark.color;
          } else {
            return ConstColor.icon.color;
          }
        },
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (state) {
          return Colors.white;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (state) {
          if (state.contains(WidgetState.selected)) {
            return ConstColor.primary.color;
          } else {
            return ConstColor.secondary.color;
          }
        },
      ),
    ),
    // ! _____ Input Theme _____ ! //
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ConstColor.secondary.color,
      hintStyle: TextStyle(
        fontSize: 14.5.sp,
        letterSpacing: 2.sp,
        fontWeight: FontWeight.w400,
        color: ConstColor.text.color,
      ),
      labelStyle: TextStyle(
        fontSize: 14.5.sp,
        letterSpacing: 2.sp,
        fontWeight: FontWeight.w400,
        color: ConstColor.icon.color,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 16.sp,
        letterSpacing: 2.sp,
        fontWeight: FontWeight.w600,
        color: ConstColor.primary.color,
      ),
      iconColor: ConstColor.icon.color,
      prefixIconColor: ConstColor.icon.color,
      border: buildBorder(),
      enabledBorder: buildBorder(),
      disabledBorder: buildBorder(),
      focusedErrorBorder: buildBorder(),
      focusedBorder: buildFocusedBorder(),
    ),
  );
}
