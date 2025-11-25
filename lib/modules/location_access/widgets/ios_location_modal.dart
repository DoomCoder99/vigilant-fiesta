import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/location_permission_service.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// iOS Location Permission Modal
/// 
/// Displays iOS-style location permission alert with:
/// - Title and description
/// - Map preview with precise location indicator
/// - Three permission options (Allow Once, Allow While Using App, Don't Allow)
/// 
/// Design Source: Figma frame "Location access - iOS" (node-id: 1-1161)
class IOSLocationModal extends StatelessWidget {
  const IOSLocationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 270,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Container(
          width: 270,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title and Description Section
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      Text(
                        'Allow "App" to use your location?',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          height: 22 / 17,
                          letterSpacing: -0.408,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Your precise location is used to show your position on the map, get directions, estimate travel times and improve search results',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          height: 16 / 13,
                          letterSpacing: -0.078,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Map Preview Section
                Container(
                  height: 174,
                  width: 270,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Map Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/ios_map_view.png',
                          width: 270,
                          height: 174,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Precise Location Toggle Badge
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 10,
                                height: 9,
                                child: Image.asset(
                                  'assets/images/precise_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Precise: On',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF007AFF), // iOS blue
                                  height: 18 / 13,
                                  letterSpacing: -0.078,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Location Pin
                      Positioned(
                        bottom: 109,
                        left: 142 - 6, // Center minus half width
                        child: SizedBox(
                          width: 12,
                          height: 12,
                          child: Image.asset(
                            'assets/images/precise_pin.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  height: 0.5,
                  color: const Color(0x4D3C3C3D), // rgba(60,60,67,0.29)
                ),

                // Permission Options
                Column(
                  children: [
                    _IOSPermissionOption(
                      text: 'Allow Once',
                      onTap: () {
                        _handlePermission(context, 'allow_once');
                      },
                    ),
                    Container(
                      height: 0.5,
                      color: const Color(0x4D3C3C3D),
                    ),
                    _IOSPermissionOption(
                      text: 'Allow While Using the App',
                      onTap: () {
                        _handlePermission(context, 'while_using_app');
                      },
                    ),
                    Container(
                      height: 0.5,
                      color: const Color(0x4D3C3C3D),
                    ),
                    _IOSPermissionOption(
                      text: 'Don\'t Allow',
                      onTap: () {
                        _handlePermission(context, 'denied');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handlePermission(BuildContext context, String permissionType) async {
    // Close the custom modal first
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // Import location permission service
    final permissionService = LocationPermissionService.instance;

    // Request actual system-generated permission
    // This will show the native iOS permission dialog
    final isGranted = await permissionService.requestPermissionWithType(permissionType);

    if (isGranted) {
      // Permission granted - navigate to Registration
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.register);
      }
    } else {
      // Permission denied - still allow user to proceed to registration
      // (Some apps allow registration without location)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission denied. You can still register.'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.register);
      }
    }
  }
}

/// iOS-style Permission Option
class _IOSPermissionOption extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _IOSPermissionOption({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 270,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF007AFF), // iOS blue
            height: 22 / 17,
            letterSpacing: -0.408,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

