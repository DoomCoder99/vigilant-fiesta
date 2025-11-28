import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../widgets/bottom_sheet.dart';

/// Profile Edit Screen
/// 
/// Allows users to edit their profile information.
/// Design Source: Figma frame "Profile edit" (node-id: 1-26131)
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Faisal Ali');
  final TextEditingController _emailController = TextEditingController(text: 'faisalali@ymail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+968 0202 4848');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showDeleteAccountConfirmation() {
    Get.toNamed(AppRoutes.accountDeleteConfirmation);
  }

  void _updateProfile() {
    // TODO: Implement profile update via repository
    Get.back();
    Get.snackbar('Success', 'Profile updated successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leadingWidth: 45,   // <-- This controls the size of the leading area
        leading: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 45,       // <-- Now your size will work
                width: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD6DEE8)),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Profile Avatar with Edit Overlay
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE6D1B0),
                  ),
                  child: Image.asset(
                    'assets/profile/profile_avatar.png',
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 40, color: AppColors.textPrimary);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      border: Border.all(color: AppColors.inputBorder),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/profile/edit_icon.png',
                      width: 12,
                      height: 12,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.edit, size: 12, color: AppColors.textPrimary);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Form Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _FormField(
                    label: 'Name',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 12),
                  _FormField(
                    label: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 12),
                  _FormField(
                    label: 'Phone',
                    controller: _phoneController,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,       // remove internal padding
                      minimumSize: Size(0, 0),        // remove minimum tap target
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap, // remove extra height
                    ),
                    onPressed: showDeleteAccountSheet,
                    child: const Text(
                      'Delete account',
                      style: TextStyle(
                        color: Color(0xFFF14336),
                        fontSize: 12,
                        fontFamily: AppFonts.figtree,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.figtree,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void showDeleteAccountSheet() {
    showConfirmationSheet(
      title: "Delete Account?",
      subtitle: "This will delete your account permanently.\nYou sure to delete?",
      cancelText: "No, Go Back",
      confirmText: "Yes, Delete Account",
      confirmColor: const Color(0xFFF14336),
      icon: Image.asset(
        "assets/profile/sick 1.png",
        height: 140,
      ),
      onConfirm: () {
        // your delete logic
        Get.back();
      },
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _FormField({
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          style: AppTextStyles.input,
          decoration: InputDecoration(
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
          ),
        ),
      ],
    );
  }
}

