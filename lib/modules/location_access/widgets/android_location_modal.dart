import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/location_permission_service.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Android Location Permission Modal
/// 
/// Displays Android-style location permission dialog with:
/// - Location icon
/// - Permission question
/// - Precise vs Approximate location visuals
/// - Three permission options (While using app, Only this time, Don't allow)
/// 
/// Design Source: Figma frame "Location access - Android" (node-id: 1-1062)
class AndroidLocationModal extends StatelessWidget {
  const AndroidLocationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 319,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Container(
          width: 319,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F1), // Light gray background
            borderRadius: BorderRadius.circular(26),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Location Icon
                SizedBox(
                  width: 28,
                  height: 28,
                  child: Image.asset(
                    'assets/images/location_icon.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Permission Question
                Text(
                  'Allow Maps to access this device\'s precise location?',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.xxxxxl),

                // Precise vs Approximate Visuals
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Precise Location
                    Column(
                      children: [
                        Container(
                          width: 123,
                          height: 123,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                          ),
                          child: Image.asset(
                            'assets/images/precise_location.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Precise',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ],
                    ),

                    // Approximate Location
                    Column(
                      children: [
                        Container(
                          width: 123,
                          height: 123,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                          ),
                          child: Image.asset(
                            'assets/images/approximate_location.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Approximate',
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF212121),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxxxxl),

                // Permission Options
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AndroidPermissionButton(
                      text: 'While using the app',
                      onTap: () {
                        _handlePermission(context, 'while_using_app');
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _AndroidPermissionButton(
                      text: 'Only this time',
                      onTap: () {
                        _handlePermission(context, 'only_once');
                      },
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _AndroidPermissionButton(
                      text: 'Don\'t allow',
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
    // This will show the native Android/iOS permission dialog
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

/// Android-style Permission Button
class _AndroidPermissionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _AndroidPermissionButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minHeight: 50,
            maxWidth: 278,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFD2E4FC), // Light blue background
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF171C23),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

