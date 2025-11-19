import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_cart_controller.dart';
import 'rent_payment_success_screen.dart';

class RentPaymentMethodScreen extends StatelessWidget {
  const RentPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<RentCartController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: Color(0xFF162028)),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Select payment method',
          style: TextStyle(
            color: Color(0xFF162028),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Figtree',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount to pay
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amount to pay',
                  style: TextStyle(
                    color: const Color(0xFF162028).withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Figtree',
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                  'OMR ${cartController.totalToPay.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF162028),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Figtree',
                  ),
                )),
              ],
            ),
            const SizedBox(height: 24),
            _buildDivider(),

            // Cards section
            const SizedBox(height: 24),
            const Text(
              'Cards',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 12),
            _buildCardOption(
              icon: 'assets/rent_vehicle/payment/mastercard.png',
              title: '5600 **** **** **62',
              subtitle: 'Master Card',
              isSelected: false,
              onTap: () {
                Get.to(() => const RentPaymentSuccessScreen());
              },
            ),
            const SizedBox(height: 12),
            _buildAddCardOption(),

            const SizedBox(height: 24),
            _buildDivider(),

            // Wallets section
            const SizedBox(height: 24),
            const Text(
              'Wallets',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 12),
            _buildWalletOption(
              icon: 'assets/rent_vehicle/payment/amazon_pay.png',
              title: 'Amazon Pay',
              subtitle: 'OMR 242',
              onTap: () {
                Get.to(() => const RentPaymentSuccessScreen());
              },
            ),

            const SizedBox(height: 24),
            _buildDivider(),

            // Net Banking section
            const SizedBox(height: 24),
            const Text(
              'Net banking',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 12),
            _buildBankOption(
              icon: 'assets/rent_vehicle/payment/net_banking.png',
              title: 'Add your bank',
              onTap: () {
                // TODO: Open bank selection
              },
            ),

            const SizedBox(height: 24),
            _buildDivider(),

            // Pay After Service section
            const SizedBox(height: 24),
            const Text(
              'Pay after service',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 12),
            _buildCashOption(
              icon: 'assets/rent_vehicle/payment/cash.png',
              title: 'Pay by cash',
              onTap: () {
                Get.to(() => const RentPaymentSuccessScreen());
              },
            ),

            const SizedBox(height: 24),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFFEBEBEB),
    );
  }

  Widget _buildCardOption({
    required String icon,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            'assets/rent_vehicle/payment/radio_unchecked.png',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.credit_card, size: 24, color: Color(0xFFD6DEE8));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF162028),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Figtree',
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF162028).withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/rent_vehicle/icons/chevron_forward.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardOption() {
    return InkWell(
      onTap: () {
        // TODO: Open add card screen
      },
      child: Row(
        children: [
          Image.asset(
            'assets/rent_vehicle/icons/add_icon.png',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              'assets/rent_vehicle/payment/add_card.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.add, size: 24, color: Color(0xFFD6DEE8));
              },
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Add new card',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Figtree',
              ),
            ),
          ),
          Image.asset(
            'assets/rent_vehicle/icons/chevron_forward.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildWalletOption({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.account_balance_wallet, size: 24, color: Color(0xFFD6DEE8));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF162028),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Figtree',
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF162028).withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/rent_vehicle/icons/chevron_forward.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildBankOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.account_balance, size: 24, color: Color(0xFFD6DEE8));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Figtree',
              ),
            ),
          ),
          Image.asset(
            'assets/rent_vehicle/icons/chevron_forward.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildCashOption({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFD6DEE8)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.asset(
              icon,
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.money, size: 24, color: Color(0xFFD6DEE8));
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Figtree',
              ),
            ),
          ),
          Image.asset(
            'assets/rent_vehicle/icons/chevron_forward.png',
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}

