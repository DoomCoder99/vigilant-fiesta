import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Wallet Screen
/// 
/// Displays wallet balance and transaction history.
/// Design Source: Figma frame "wallet" (node-id: 1-25908)
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
          'Wallet',
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
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  border: Border.all(color: const Color(0xFFD6DEE8)),
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/wallet/wallet_icon.png',
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.account_balance_wallet, size: 32);
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Total Money in Wallet',
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '2864.04',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.figtree,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            // TODO: Navigate to add money screen
                          },
                          icon: Image.asset(
                            'assets/profile/add_icon.png',
                            width: 12,
                            height: 12,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.add, size: 12, color: AppColors.primary);
                            },
                          ),
                          label: const Text(
                            'Add Money',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: AppFonts.figtree,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        border: Border.all(color: const Color(0xFFD6DEE8)),
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invites',
                            style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '02',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.figtree,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        border: Border.all(color: const Color(0xFFD6DEE8)),
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refund',
                            style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '00',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppFonts.figtree,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Refer & Earn Section (reused from Profile & More)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Refer & Earn big!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.figtree,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Invite your friends and earn rewards. The more you share, the more you gain.',
                      style: AppTextStyles.caption.copyWith(fontSize: 10, height: 1.2),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        border: Border.all(color: const Color(0xFFDADADA)),
                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'www.amozit.com/referral/483BBJ78xh64',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textPrimary.withOpacity(0.5),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/profile/copy_icon.png',
                              width: 16,
                              height: 16,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.copy, size: 16);
                              },
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Referral link copied!')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement share functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/profile/share_icon.png',
                              width: 12,
                              height: 12,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.share, size: 12, color: Colors.white);
                              },
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'share with friends',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.figtree,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

