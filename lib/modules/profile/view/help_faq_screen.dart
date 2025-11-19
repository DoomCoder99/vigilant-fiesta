import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Help FAQ Screen
/// 
/// Displays frequently asked questions.
/// Design Source: Figma frame "Help - FAQ" (node-id: 1-25654)
class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {
  int? _expandedIndex;

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'How can I reset my password?',
      'answer': 'To reset your password, go to the Sign In screen and tap "Forgot Password". Enter your email or phone number and follow the instructions.',
    },
    {
      'question': 'How to change my address?',
      'answer': 'Go to Profile & More > Addresses. Tap on the address you want to edit, make your changes, and save.',
    },
    {
      'question': 'Maecenas bibendum orci in enim porta, quis mattis purus dapibus?',
      'answer': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'question': 'Aenean eget lectus a lorem?',
      'answer': 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'question': 'Donec blandit venenatis sem et mollis?',
      'answer': 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    },
  ];

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
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFD9D9D9)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'FAQ',
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
          // FAQ List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(25),
              itemCount: _faqs.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final faq = _faqs[index];
                final isExpanded = _expandedIndex == index;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            faq['question'] as String,
                            style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_up : Icons.chevron_right,
                          size: 20,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Query Input
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Didn\'t find what you want? Raise a query.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Type here',
                    hintStyle: AppTextStyles.input.copyWith(
                      color: AppColors.inputPlaceholder,
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      borderSide: const BorderSide(color: AppColors.inputBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      borderSide: const BorderSide(color: AppColors.inputBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      borderSide: const BorderSide(color: AppColors.inputBorder),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: Image.asset(
                      'assets/profile/mic_icon.png',
                      width: 16,
                      height: 16,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.mic, size: 16);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

