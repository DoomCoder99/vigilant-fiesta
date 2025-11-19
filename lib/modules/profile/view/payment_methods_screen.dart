import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';

/// Payment Methods Screen
/// 
/// Lists user's saved payment methods.
/// Design Source: Figma frame "payment method - card added" (node-id: 1-26283, 1-26902)
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  void _showAddNewCardPopup() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AddNewCardPopup(),
    );
  }

  void _showExistingCardPopup(String cardId) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ExistingCardPopup(cardId: cardId),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mock payment methods
    final paymentMethods = [
      {
        'type': 'card',
        'name': 'Master Card',
        'number': '5600 **** **** **62',
        'isDefault': true,
        'id': 'card1',
      },
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
          'Payment methods',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          // Cards Section
          const Text(
            'Cards',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: AppFonts.figtree,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...paymentMethods.map((method) => _PaymentMethodCard(
                method: method,
                onTap: () => _showExistingCardPopup(method['id'] as String),
              )),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: _showAddNewCardPopup,
            icon: const Icon(Icons.add, size: 16, color: AppColors.primary),
            label: const Text(
              'Add new card',
              style: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.figtree,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final Map<String, dynamic> method;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.method,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          border: Border.all(color: const Color(0xFFD6DEE8)),
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/wallet/mastercard.png',
              width: 40,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.credit_card, size: 40);
              },
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['name'] as String,
                    style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                  ),
                  Text(
                    method['number'] as String,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            if (method['isDefault'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.primary,
                    fontFamily: AppFonts.figtree,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddNewCardPopup extends StatefulWidget {
  const _AddNewCardPopup();

  @override
  State<_AddNewCardPopup> createState() => _AddNewCardPopupState();
}

class _AddNewCardPopupState extends State<_AddNewCardPopup> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _saveCard = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add new card',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.figtree,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/profile/close_icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.close, size: 20);
                  },
                ),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _cardNumberController,
            decoration: InputDecoration(
              hintText: 'Card number',
              prefixIcon: Image.asset(
                'assets/wallet/card_icon.png',
                width: 16,
                height: 16,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.credit_card, size: 16);
                },
              ),
              suffixIcon: Image.asset(
                'assets/profile/mic_icon.png',
                width: 16,
                height: 16,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.mic, size: 16);
                },
              ),
              filled: true,
              fillColor: AppColors.backgroundWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expiryController,
                  decoration: InputDecoration(
                    hintText: 'MM/YY',
                    suffixIcon: Image.asset(
                      'assets/profile/mic_icon.png',
                      width: 16,
                      height: 16,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.mic, size: 16);
                      },
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      borderSide: const BorderSide(color: AppColors.inputBorder),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _cvvController,
                  decoration: InputDecoration(
                    hintText: 'CVV',
                    suffixIcon: Image.asset(
                      'assets/profile/mic_icon.png',
                      width: 16,
                      height: 16,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.mic, size: 16);
                      },
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      borderSide: const BorderSide(color: AppColors.inputBorder),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(
                value: _saveCard,
                onChanged: (value) {
                  setState(() {
                    _saveCard = value ?? false;
                  });
                },
                activeColor: AppColors.primary,
              ),
              const Text(
                'Save the card details securely',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: AppFonts.figtree,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Save card via repository
                Get.back();
                Get.snackbar('Card Added', 'Card added successfully');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Save & Proceed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.figtree,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExistingCardPopup extends StatelessWidget {
  final String cardId;

  const _ExistingCardPopup({required this.cardId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Card Options',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.figtree,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: Image.asset(
                  'assets/profile/close_icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.close, size: 20);
                  },
                ),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Set as default'),
            onTap: () {
              // TODO: Set as default
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit card'),
            onTap: () {
              // TODO: Edit card
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Remove card', style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: Remove card
              Get.back();
              Get.snackbar('Card Removed', 'Card removed successfully');
            },
          ),
        ],
      ),
    );
  }
}

