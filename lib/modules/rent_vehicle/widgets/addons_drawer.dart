import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/rent_cart_controller.dart';
import '../../../data/models/addon_model.dart';
import '../view/rent_cart_screen.dart';

class AddOnsDrawer extends StatelessWidget {
  const AddOnsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<RentCartController>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add - ons',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF162028),
                      fontFamily: 'Figtree',
                    ),
                  ),
                  Obx(() {
                    final hasItems = cartController.cartItems.isNotEmpty;
                    if (hasItems) {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/rent_vehicle/icons/close_small_addons.png',
                          width: 20,
                          height: 20,
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7132F4),
                            fontFamily: 'Figtree',
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
              const SizedBox(height: 24),

              // Add-ons list
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: cartController.addons.map((addon) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _buildAddonCard(addon, cartController),
                    ),
                  );
                }).toList(),
              )),

              // Continue button (only shown when items are added)
              Obx(() {
                if (cartController.cartItems.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(() => const RentCartScreen());
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
                                  '${cartController.totalItems}',
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
                          Row(
                            children: [
                              const Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: 'Figtree',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                'assets/rent_vehicle/icons/chevron_forward_white.png',
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddonCard(AddonModel addon, RentCartController controller) {
    AddonModel? cartItem;
    try {
      cartItem = controller.cartItems.firstWhere((item) => item.id == addon.id);
    } catch (e) {
      cartItem = null;
    }
    final isInCart = cartItem != null;
    final quantity = cartItem?.quantity ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with rating badge
        Stack(
          children: [
            Container(
              height: 102,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(addon.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      addon.rating.toStringAsFixed(addon.rating == 5.0 ? 0 : 1),
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF162028),
                        fontFamily: 'Figtree',
                      ),
                    ),
                    const SizedBox(width: 2),
                    Image.asset(
                      'assets/rent_vehicle/icons/star.png',
                      width: 8,
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Name
        Text(
          addon.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF162028),
            fontFamily: 'Figtree',
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),

        // Price
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              addon.price.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF162028),
                fontFamily: 'Figtree',
              ),
            ),
            const SizedBox(width: 2),
            const Text(
              'OMR',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: Color(0xFF162028),
                fontFamily: 'Figtree',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Button or quantity selector
        if (isInCart)
          Container(
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
                    controller.updateQuantity(addon.id, quantity - 1);
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
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF162028),
                    fontFamily: 'Figtree',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateQuantity(addon.id, quantity + 1);
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
          )
        else
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                controller.addToCart(addon);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF7132F4)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'add to cart',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7132F4),
                  fontFamily: 'Figtree',
                ),
              ),
            ),
          ),
      ],
    );
  }
}

