import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_flix/core/const/app_themes.dart';

/// A widget that displays the profile header, including the user's avatar and
/// name.
///
/// The header contains a circular profile image and the user's name. The
/// profile image is fetched from the assets, and the name is a placeholder.
class ProfilePageHeader extends StatelessWidget {
  /// Creates an instance of [ProfilePageHeader].
  ///
  /// The [key] parameter is used to uniquely identify this widget within the
  /// widget tree.
  const ProfilePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Displays the user's profile image in a circular container.
        Container(
          width: Get.size.height * .08,
          height: Get.size.height * .08,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: const AssetImage('assets/photo/profile.jpeg')
                  as ImageProvider,
              fit: BoxFit.fill,
            ),
            border: Border.all(color: AppThemes.darkBlue, width: 2.0),
          ),
        ),
        SizedBox(
          width: AppThemes().biggerSpacing,
        ),
        /// Displays the user's name.
        Text(
          "Guest #149282900",
          style: AppThemes().text5Bold(color: AppThemes.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
