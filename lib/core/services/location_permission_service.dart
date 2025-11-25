import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Location Permission Service
/// 
/// Handles location permission requests following WDI patterns.
/// Uses platform-specific permission handling via permission_handler package.
class LocationPermissionService {
  LocationPermissionService._();
  static final LocationPermissionService instance = LocationPermissionService._();

  /// Request location permission
  /// 
  /// Returns true if permission is granted, false otherwise.
  /// Uses system-generated permission dialogs (Android/iOS native).
  Future<bool> requestPermission() async {
    try {
      // Request location permission using permission_handler
      // This will show the system-generated permission dialog
      final status = await Permission.location.request();
      
      if (kDebugMode) {
        print('[LocationPermissionService] Permission status: $status');
      }
      
      // Return true if permission is granted (always or whileInUse)
      return status.isGranted;
    } catch (e) {
      if (kDebugMode) {
        print('[LocationPermissionService] Error requesting permission: $e');
      }
      return false;
    }
  }

  /// Check if location permission is already granted
  /// 
  /// Returns true if permission is already granted, false otherwise.
  Future<bool> isPermissionGranted() async {
    try {
      final status = await Permission.location.status;
      return status.isGranted;
    } catch (e) {
      if (kDebugMode) {
        print('[LocationPermissionService] Error checking permission: $e');
      }
      return false;
    }
  }

  /// Request location permission with specific type (for Android)
  /// 
  /// [permissionType] can be:
  /// - 'while_using_app': Request while using app permission
  /// - 'only_once': Request one-time permission (Android 11+)
  /// - 'denied': User denied permission
  Future<bool> requestPermissionWithType(String permissionType) async {
    if (permissionType == 'denied') {
      return false;
    }
    
    // For Android, we can request precise location permission
    // For iOS, the system handles the permission type automatically
    if (Platform.isAndroid && permissionType == 'only_once') {
      // Android 11+ supports one-time permission
      // Note: permission_handler handles this automatically
    }
    
    return requestPermission();
  }

  /// Get platform type
  bool get isAndroid => Platform.isAndroid;
  bool get isIOS => Platform.isIOS;
}

