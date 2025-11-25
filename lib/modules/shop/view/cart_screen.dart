import 'package:flutter/material.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/widgets/amozit_empty_state_widget.dart';
import '../services/cart_service.dart';

/// Cart Screen
/// 
/// Displays shopping cart items and checkout functionality.
/// Design Source: Figma frame "My cart - services only" (node-id: 1-4160)
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _selectedAddress = 'Al Farwaniyah';
  int _itemQuantity = 1;
  final CartService _cartService = CartService.instance;

  @override
  void initState() {
    super.initState();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = _cartService.itemCount == 0;
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 16),
          onPressed: () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(10),
            minimumSize: const Size(36, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: AppColors.textSecondary),
            ),
          ),
        ),
        title: Text(
          'My Cart',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w500, // Medium weight as per Figma
          ),
        ),
        centerTitle: true,
      ),
      body: isEmpty
          ? AmozitEmptyStateWidget(
              title: 'Your cart is empty',
              description: 'It\'s empty in here. Check out our\nproducts & services.',
              assetPath: 'assets/blank_states/cart_empty.png',
              primaryCtaLabel: 'Shop Now',
              onPrimaryCtaTap: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.shopLanding);
              },
              secondaryCtaLabel: 'Explore Services',
              onSecondaryCtaTap: () {
                // TODO: Navigate to services screen
                Navigator.of(context).pushReplacementNamed(AppRoutes.shopLanding);
              },
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery address section
                  _buildDeliverySection(),
                  const SizedBox(height: AppSpacing.xxl),
                  // Shopping cart items
                  _buildCartItems(),
                  const SizedBox(height: AppSpacing.xxl),
                  // Coupon section
                  _buildCouponSection(),
                  const SizedBox(height: AppSpacing.xxl),
                  // Payment summary
                  _buildPaymentSummary(),
                ],
              ),
            ),
      bottomNavigationBar: isEmpty ? null : _buildBottomBar(context),
    );
  }

  Widget _buildDeliverySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deliver to',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            border: Border.all(color: AppColors.textSecondary),
            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
          ),
          child: Column(
            children: [
              _buildAddressOption(
                'Al Farwaniyah',
                'Block 4, Al Farwaniyah, Oman',
                'Home',
                Icons.home,
                isSelected: _selectedAddress == 'Al Farwaniyah',
                onTap: () {
                  setState(() {
                    _selectedAddress = 'Al Farwaniyah';
                  });
                },
              ),
              const Divider(height: 1),
              _buildAddressOption(
                'Salala',
                'Street 23, Salala, Oman',
                'Work',
                Icons.business_center,
                isSelected: _selectedAddress == 'Salala',
                onTap: () {
                  setState(() {
                    _selectedAddress = 'Salala';
                  });
                },
              ),
              const Divider(height: 1),
              InkWell(
                onTap: () {
                  // TODO: Navigate to add address screen
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 16, color: AppColors.textPrimary),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Add new address',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textPrimary.withOpacity(0.6),
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
    );
  }

  Widget _buildAddressOption(
    String title,
    String address,
    String label,
    IconData labelIcon, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Radio<String>(
              value: title,
              groupValue: _selectedAddress,
              onChanged: (_) => onTap(),
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    address,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textPrimary.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                border: Border.all(color: AppColors.textSecondary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(labelIcon, size: 12, color: AppColors.textPrimary),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    label,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shopping Cart',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildCartItem(),
      ],
    );
  }

  Widget _buildCartItem() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Bose QuietComfort® 45 Headphones',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary.withOpacity(0.6),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.6),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      if (_itemQuantity > 1) {
                        setState(() {
                          _itemQuantity--;
                        });
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(8, 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '-',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                    child: Text(
                      '$_itemQuantity',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _itemQuantity++;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(8, 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      '+',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            SizedBox(
              width: 64,
              child: Text(
                'OMR 12.04',
                textAlign: TextAlign.right,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textPrimary.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCouponSection() {
    return Column(
      children: [
        const Divider(height: 1),
        TextButton(
          onPressed: () {
            // TODO: Show coupon code input dialog
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Apply coupon code',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment summary',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600, // SemiBold as per Figma
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildSummaryRow('Item total', 'OMR 12.04'),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Platform fee', 'OMR 4'),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Taxes', 'OMR 3.96'),
        const Divider(height: 1),
        const SizedBox(height: AppSpacing.md),
        _buildSummaryRow('Total to pay', 'OMR 20', isTotal: true),
        const Divider(height: 1),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Cancellation policy',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600, // SemiBold as per Figma
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies lacus.',
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            color: AppColors.textPrimary.withOpacity(0.6),
            fontWeight: isTotal ? FontWeight.normal : FontWeight.normal,
          ),
        ),
        SizedBox(
          width: 64,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 12,
              color: AppColors.textPrimary.withOpacity(0.6),
              fontWeight: isTotal ? FontWeight.normal : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.paymentMethod);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxxxl,
              vertical: AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppBorderRadius.lg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundWhite,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$_itemQuantity',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      width: 1,
                      height: 16,
                      color: AppColors.backgroundWhite.withOpacity(0.3),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'OMR 20',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.backgroundWhite,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Continue',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.backgroundWhite,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Icons.chevron_right, size: 20, color: AppColors.backgroundWhite),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

