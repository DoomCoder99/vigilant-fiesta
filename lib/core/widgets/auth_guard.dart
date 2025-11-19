import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

/// Auth Guard Widget
/// 
/// Wraps protected routes and redirects to Sign In if user is not authenticated.
/// Following WDI patterns for route protection.
class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final authService = AuthService.instance;

    // Check authentication status
    if (!authService.isAuthenticated) {
      // User not authenticated - redirect to Sign In
      // Use a post-frame callback to avoid build-time navigation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
        }
      });

      // Show loading or empty widget while redirecting
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // User is authenticated - show protected content
    return child;
  }
}

