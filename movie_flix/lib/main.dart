import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_flix/core/const/app_themes.dart';
import 'dart:developer';
import 'package:movie_flix/utils/app_pages.dart';
import 'package:movie_flix/utils/app_routes.dart';

/// The entry point of the application.
///
/// Initializes Flutter bindings, sets the preferred orientation for the app,
/// and runs the [MyApp] widget.
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

/// The root widget of the application.
///
/// The `MyApp` widget sets up the application-wide configuration, including
/// theme data, initial route, and page routing. It uses the [GetMaterialApp]
/// from the GetX package for state management and routing.
///
/// Example usage:
/// 
/// ```dart
/// runApp(MyApp());
/// ```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppThemes.blue,
        appBarTheme: const AppBarTheme(color: AppThemes.blue),
        iconTheme: const IconThemeData(
          color: AppThemes.white,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: AppThemes.white,
        ),
      ),
      initialRoute: AppRoutes.userDashboard,
      getPages: AppPages.pages,
    );
  }
}
