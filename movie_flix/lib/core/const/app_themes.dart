import 'package:flutter/material.dart';

/// Provides a set of predefined colors and text styles used throughout the app.
///
/// The `AppThemes` class contains color constants, spacing values, and text styles
/// that are used consistently across the application to maintain a uniform look and feel.
///
/// Color constants include various shades of blue, red, green, and other colors.
/// Text styles include different font sizes and weights to standardize text appearance.
class AppThemes {
  /// Dark blue color used in the app.
  static const darkBlue = Color.fromARGB(255, 25, 59, 109);

  /// Standard blue color used in the app.
  static const blue = Color.fromARGB(255, 57, 126, 191);

  /// Light blue color used in the app.
  static const lightBlue = Color(0xff127BDC);

  /// Red color used in the app.
  static const red = Color(0xffF21212);

  /// Green color used in the app.
  static const green = Color(0xff177315);

  /// Very light blue color used in the app.
  static const superLightBlue = Color(0xffE6F3FC);

  /// White color used in the app.
  static const white = Colors.white;

  /// Black color used in the app.
  static const black = Colors.black;

  /// Default height for form text fields.
  final double defaultFormHeight = 55.0;

  /// Minimum spacing used in the app.
  final double minSpacing = 4.0;

  /// Default spacing used in the app.
  final double defaultSpacing = 8.0;

  /// Larger spacing used in the app.
  final double biggerSpacing = 12.0;

  /// Extra spacing used in the app.
  final double extraSpacing = 16.0;

  /// Very extra spacing used in the app.
  final double veryExtraSpacing = 30.0;

  /// Returns a [TextStyle] for primary text with a font size of 32.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text1({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 32,
    );
  }

  /// Returns a [TextStyle] for secondary text with a font size of 24.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text2({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 24,
    );
  }

  /// Returns a [TextStyle] for tertiary text with a font size of 18.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text3({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 18,
    );
  }

  /// Returns a [TextStyle] for text with a font size of 16.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text4({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
    );
  }

  /// Returns a [TextStyle] for text with a font size of 14.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text5({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 14,
    );
  }

  /// Returns a [TextStyle] for text with a font size of 12.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text6({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 12,
    );
  }

  /// Returns a [TextStyle] for text with a font size of 10.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text7({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 10,
    );
  }

  /// Returns a bold [TextStyle] for primary text with a font size of 32.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text1Bold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 32,
      fontWeight: FontWeight.w700,
    );
  }

  /// Returns a bold [TextStyle] for secondary text with a font size of 24.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text2Bold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }

  /// Returns a bold [TextStyle] for tertiary text with a font size of 18.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text3Bold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  /// Returns a bold [TextStyle] for tertiary text with a shadow effect.
  ///
  /// The [color] parameter specifies the color of the text.
  /// 
  /// The text will have a shadow with an offset of (2.0, 2.0) and a blur radius of 3.0.
  TextStyle text3BoldShadow({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      shadows: [
        Shadow(
          offset: Offset(2.0, 2.0),
          blurRadius: 3.0,    
          color: Colors.black.withOpacity(0.5),
        ),
      ],
    );
  }

  /// Returns a bold [TextStyle] for text with a font size of 16.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text4Bold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
  }

  /// Returns a semi-bold [TextStyle] for text with a font size of 16.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text4SemiBold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  /// Returns a bold [TextStyle] for text with a font size of 14.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text5Bold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
  }

  /// Returns a bold [TextStyle] for text with a font size of 12.
  ///
  /// The [color] parameter specifies the color of the text.
  TextStyle text6Bold({required Color color}) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );
  }
}
