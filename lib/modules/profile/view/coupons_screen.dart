import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Coupons Screen
/// 
/// Displays available coupons and loyalty cards.
/// Design Source: Figma frame "Coupons" (node-id: 1-26379)
class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Coupons & Loyalty cards',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textPrimary.withOpacity(0.5),
          labelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            fontFamily: AppFonts.figtree,
          ),
          tabs: const [
            Tab(text: 'Coupons'),
            Tab(text: 'Loyalty cards'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _CouponsTab(),
          _LoyaltyCardsTab(),
        ],
      ),
    );
  }
}

class _CouponsTab extends StatelessWidget {
  final List<Map<String, dynamic>> _coupons = [
    {
      'code': 'LOYALTY20',
      'title': 'Save 20% on Home Cleaning services',
      'description': 'Use code LOYALTY20 and get 20% discount of up to OMR 20 on your next Home Cleaning service.',
      'validTill': '30 Nov 2025',
      'discount': '20% OFF',
      'isExpired': false,
    },
    {
      'code': 'WELCOME10',
      'title': 'Save 10% on Shopping Cart',
      'description': 'Use code WELCOME10 and get 10% discount of up to OMR 40 on your next shopping.',
      'validTill': '31 Dec 2025',
      'discount': '10% OFF',
      'isExpired': false,
    },
    {
      'code': 'OFFER20',
      'title': 'Save 20% on Turf Booking',
      'description': 'Use code OFFER20 and get 20% discount of up to OMR 100 on your next Turf booking.',
      'validTill': '31 Sep 2025',
      'discount': '10% OFF',
      'isExpired': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expiring soon',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: AppFonts.figtree,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._coupons.where((c) => !c['isExpired']).map((coupon) => _CouponCard(coupon: coupon)),
          const SizedBox(height: 24),
          const Text(
            'more coupons',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: AppFonts.figtree,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._coupons.where((c) => !c['isExpired'] && _coupons.indexOf(c) > 0).map((coupon) => _CouponCard(coupon: coupon)),
          const SizedBox(height: 24),
          const Text(
            'Expired coupons',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: AppFonts.figtree,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._coupons.where((c) => c['isExpired']).map((coupon) => _CouponCard(coupon: coupon)),
        ],
      ),
    );
  }
}

class _CouponCard extends StatelessWidget {
  final Map<String, dynamic> coupon;

  const _CouponCard({required this.coupon});

  @override
  Widget build(BuildContext context) {
    final isExpired = coupon['isExpired'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Discount Badge
          Container(
            width: 36,
            decoration: BoxDecoration(
              color: isExpired ? const Color(0xFFC6CED5) : AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  coupon['discount'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.figtree,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // Coupon Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon['code'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.figtree,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    coupon['title'] as String,
                    style: AppTextStyles.caption.copyWith(fontSize: 10),
                  ),
                  const Divider(height: 1),
                  Text(
                    coupon['description'] as String,
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.textPrimary.withOpacity(0.8),
                    ),
                  ),
                  const Divider(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Valid till ${coupon['validTill']}',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 8,
                          color: AppColors.textPrimary.withOpacity(0.8),
                        ),
                      ),
                      if (!isExpired)
                        OutlinedButton(
                          onPressed: () {
                            // TODO: Apply coupon
                            Get.snackbar('Coupon Applied', 'Coupon ${coupon['code']} applied successfully');
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.figtree,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoyaltyCardsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          // TODO: Implement loyalty cards list
          const Text('Loyalty Cards - Coming Soon'),
        ],
      ),
    );
  }
}

