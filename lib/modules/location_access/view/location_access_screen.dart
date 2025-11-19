import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/android_location_modal.dart';
import '../widgets/ios_location_modal.dart';
import '../widgets/location_access_base.dart';

/// Location Access Screen
/// 
/// Onboarding screen requesting location permission from the user.
/// Shows platform-specific UI (Android vs iOS) based on the current platform.
/// 
/// Design Sources:
/// - Android: Figma frame "Location access - Android" (node-id: 1-1062)
/// - iOS: Figma frame "Location access - iOS" (node-id: 1-1161)
class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar style to dark (dark icons on light background)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return LocationAccessBase(
      child: Platform.isAndroid
          ? const AndroidLocationModal()
          : const IOSLocationModal(),
    );
  }
}

