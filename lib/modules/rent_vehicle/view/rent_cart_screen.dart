import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/rent_cart_controller.dart';
import 'rent_payment_method_screen.dart';

class RentCartScreen extends StatelessWidget {
  const RentCartScreen({super.key});

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
          'My Cart',
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
            // Rent A Vehicle section
            Obx(() {
              final vehicle = cartController.selectedVehicle.value;
              final startDate = cartController.startDate.value;
              final endDate = cartController.endDate.value;

              if (vehicle == null || startDate == null || endDate == null) {
                return const SizedBox.shrink();
              }

              final days = endDate.difference(startDate).inDays + 1;
              final dateFormat = DateFormat('dd MMM yyyy');

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rent a vehicle',
                    style: TextStyle(
                      color: Color(0xFF162028),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Figtree',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vehicle.name,
                            style: const TextStyle(
                              color: Color(0xFF162028),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Figtree',
                            ),
                          ),
                          Text(
                            '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
                            style: const TextStyle(
                              color: Color(0xFF162028),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Figtree',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7132F4).withOpacity(0.1),
                              border: Border.all(
                                color: const Color(0xFF7132F4).withOpacity(0.6),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '$days days',
                              style: const TextStyle(
                                color: Color(0xFF162028),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Figtree',
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SizedBox(
                            width: 64,
                            child: Text(
                              'OMR ${cartController.vehicleTotal.toStringAsFixed(2)}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xFF162028),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Figtree',
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
            _buildDivider(),

            // Shopping Cart section
            const SizedBox(height: 24),
            const Text(
              'Shopping Cart',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'No items in cart',
                    style: TextStyle(
                      color: Color(0x99162028),
                      fontSize: 12,
                      fontFamily: 'Figtree',
                    ),
                  ),
                );
              }

              return Column(
                children: cartController.cartItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              color: Color(0x99162028),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Figtree',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 72,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7132F4).withOpacity(0.1),
                            border: Border.all(
                              color: const Color(0xFF7132F4).withOpacity(0.6),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartController.updateQuantity(item.id, item.quantity - 1);
                                },
                                icon: const Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF162028),
                                    fontFamily: 'Figtree',
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF162028),
                                  fontFamily: 'Figtree',
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cartController.updateQuantity(item.id, item.quantity + 1);
                                },
                                icon: const Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF162028),
                                    fontFamily: 'Figtree',
                                  ),
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 64,
                          child: Text(
                            'OMR ${(item.price * item.quantity).toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0x99162028),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Figtree',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
            const SizedBox(height: 16),
            const Text(
              'Apply coupon code',
              style: TextStyle(
                color: Color(0xFF7132F4),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 24),
            _buildDivider(),

            // Payment Summary
            const SizedBox(height: 24),
            const Text(
              'Payment summary',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => Column(
              children: [
                _buildSummaryRow('Item total', cartController.itemTotal),
                _buildSummaryRow('Platform fee', cartController.platformFee.value),
                _buildSummaryRow('Taxes', cartController.taxes.value),
                const SizedBox(height: 12),
                _buildDivider(),
                const SizedBox(height: 12),
                _buildSummaryRow('Total to pay', cartController.totalToPay, isTotal: true),
                const SizedBox(height: 12),
                _buildDivider(),
              ],
            )),

            // Cancellation Policy
            const SizedBox(height: 24),
            const Text(
              'Cancellation policy',
              style: TextStyle(
                color: Color(0xFF162028),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at ultricies lacus.',
              style: TextStyle(
                color: Color(0x99162028),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFEBEBEB), width: 1),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const RentPaymentMethodScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7132F4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${cartController.totalItems + 1}',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7132F4),
                          fontFamily: 'Figtree',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 16,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'OMR ${cartController.totalToPay.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'Figtree',
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Figtree',
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color(0xFFEBEBEB),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0x99162028),
              fontSize: 12,
              fontWeight: isTotal ? FontWeight.w400 : FontWeight.w400,
              fontFamily: 'Figtree',
            ),
          ),
          SizedBox(
            width: 64,
            child: Text(
              'OMR ${amount.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xFF162028),
                fontSize: 12,
                fontWeight: isTotal ? FontWeight.w400 : FontWeight.w400,
                fontFamily: 'Figtree',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

