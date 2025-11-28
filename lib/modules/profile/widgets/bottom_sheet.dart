import 'package:flutter/material.dart';
import 'package:get/get.dart';



void showConfirmationSheet({
  required String title,
  required String subtitle,
  required String confirmText,
  required Color confirmColor,
  required String cancelText,
  required Widget icon,
  required VoidCallback onConfirm,
}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ICON
          icon,
          const SizedBox(height: 20),

          /// TITLE
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          /// SUBTITLE
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 30),

          /// BUTTONS ROW
          Row(
            children: [
              /// CANCEL BUTTON
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C4BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    cancelText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// CONFIRM BUTTON (OUTLINED)
              Expanded(
                child: OutlinedButton(
                  onPressed: onConfirm,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: confirmColor, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      color: confirmColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}