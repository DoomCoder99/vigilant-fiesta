import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Help Contact Screen
/// 
/// Provides contact options for support.
/// Design Source: Figma frame "Help - contact" (node-id: 1-25809)
class HelpContactScreen extends StatelessWidget {
  const HelpContactScreen({super.key});

  void _callPhone() async {
    final uri = Uri.parse('tel:+96812345678');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch phone dialer');
    }
  }

  void _sendEmail() async {
    final uri = Uri.parse('mailto:support@amozit.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch email client');
    }
  }

  void _openChat() {
    // TODO: Open chat support
    Get.snackbar('Chat', 'Chat support coming soon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Help',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFD9D9D9)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.helpFaq),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'FAQ',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.figtree,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.helpPolicies),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Policies',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          fontFamily: AppFonts.figtree,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFonts.figtree,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _ContactOption(
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '+968 1234 5678',
              onTap: _callPhone,
            ),
            const SizedBox(height: 16),
            _ContactOption(
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'support@amozit.com',
              onTap: _sendEmail,
            ),
            const SizedBox(height: 16),
            _ContactOption(
              icon: Icons.chat_bubble_outline,
              title: 'Chat Support',
              subtitle: 'Available 24/7',
              onTap: _openChat,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: const Color(0xFFD6DEE8)),
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppColors.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}

