import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';
import 'policy_detail_popup.dart';

/// Help Policies Screen
/// 
/// Displays app policies.
/// Design Source: Figma frame "help - policies" (node-id: 1-25731)
class HelpPoliciesScreen extends StatelessWidget {
  const HelpPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      'Privacy Policy',
      'Terms of Service',
      'Refund Policy',
      'Cancellation Policy',
    ];

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
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Policies',
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
                Expanded(
                  child: InkWell(
                    onTap: () => Get.toNamed(AppRoutes.helpContact),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Contact',
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
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(25),
        itemCount: policies.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              policies[index],
              style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => PolicyDetailPopup(policyName: policies[index]),
              );
            },
          );
        },
      ),
    );
  }
}

