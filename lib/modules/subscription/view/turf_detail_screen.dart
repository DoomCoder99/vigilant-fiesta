import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../controller/subscription_detail_controller.dart';

/// Turf Detail Screen
/// 
/// Displays venue details with subscription plan and slot selection.
/// Design Source: Figma frames "Turf detail" (node-id: 1-16106, 1-16341, 1-16472)
class TurfDetailScreen extends StatelessWidget {
  const TurfDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionDetailController());

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEBEBEB)),
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.arrow_back, size: 16, color: AppColors.textPrimary),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Subscription Plans',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoadingVenue.value || controller.venue.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final venue = controller.venue.value!;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              
              // Venue info header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue.name,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              venue.rating.toStringAsFixed(0),
                              style: AppTextStyles.caption.copyWith(fontSize: 8),
                            ),
                            const Icon(Icons.star, size: 8, color: Color(0xFFFFB800)),
                            Text(
                              ' (${venue.bookingCount} bookings)',
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 8,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              venue.location,
                              style: AppTextStyles.caption.copyWith(fontSize: 8),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/subscriptions/sports/shield_verified.png',
                        width: 20,
                        height: 20,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.verified,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Amozit Verified',
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 8,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // Select Court section
              _buildSelectCourtSection(controller),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // Select Plan section
              _buildSelectPlanSection(controller),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // Starting Date section
              _buildStartingDateSection(controller),
              
              const SizedBox(height: AppSpacing.xxl),
              
              // Select Slot section
              _buildSelectSlotSection(controller),
              
              const SizedBox(height: 100), // Space for bottom button
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() => _buildBottomBar(controller)),
    );
  }

  Widget _buildSelectCourtSection(SubscriptionDetailController controller) {
    final courtTypes = ['Clay Court', 'Grass Court', 'Synthetic Court'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select court',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: courtTypes.map((court) {
            final isSelected = controller.selectedCourtType.value == court;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => controller.selectCourtType(court),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.backgroundWhite,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.6)
                            : const Color(0xFFD6DEE8),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      court,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        color: isSelected
                            ? AppColors.textPrimary
                            : const Color(0xFF7B91A3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelectPlanSection(SubscriptionDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select plan',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...controller.plans.map((plan) {
          final isSelected = controller.selectedPlan.value?.id == plan.id;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: GestureDetector(
              onTap: () => controller.selectPlan(plan),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.backgroundWhite,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFD6DEE8),
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                plan.name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                              if (plan.isBestOption) ...[
                                const SizedBox(width: AppSpacing.sm),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Best Option',
                                    style: AppTextStyles.caption.copyWith(
                                      fontSize: 9,
                                      color: AppColors.backgroundWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            plan.description,
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 12,
                              color: AppColors.textPrimary.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? AppColors.primary : const Color(0xFFD6DEE8),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStartingDateSection(SubscriptionDetailController controller) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            border: Border.all(color: const Color(0xFFD6DEE8)),
            borderRadius: BorderRadius.circular(28),
          ),
          child: const Icon(Icons.calendar_today, size: 16, color: AppColors.textPrimary),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Starting date',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                  color: AppColors.textPrimary.withValues(alpha: 0.6),
                ),
              ),
              Text(
                controller.startDate.value != null
                    ? DateFormat('dd MMM yyyy').format(controller.startDate.value!)
                    : 'Select date',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: Get.context!,
              initialDate: controller.startDate.value ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              controller.updateStartDate(date);
            }
          },
          child: Text(
            'Change',
            style: AppTextStyles.caption.copyWith(
              fontSize: 10,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectSlotSection(SubscriptionDetailController controller) {
    final timeSlots = [
      '08:00 - 09:00 AM',
      '09:00 - 10:00 AM',
      '10:00 - 11:00 AM',
      '11:00 - 12:00 PM',
      '04:00 - 05:00 PM',
      '05:00 - 06:00 PM',
      '06:00 - 07:00 PM',
      '07:00 - 08:00 PM',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select slot',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: timeSlots.map((slot) {
            final isSelected = controller.selectedSlot.value?.timeRange == slot;
            return GestureDetector(
              onTap: () => controller.selectTimeSlot(slot),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : AppColors.backgroundWhite,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.6)
                        : const Color(0xFFCFDCE7),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  slot,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: isSelected
                        ? AppColors.textPrimary
                        : const Color(0xFF7B91A3),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar(SubscriptionDetailController controller) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Row(
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
                          '1',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 8,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'OMR ${controller.totalPrice.toStringAsFixed(0)}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.backgroundWhite,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: controller.canProceed
                        ? () {
                            final cartItem = controller.createCartItem();
                            if (cartItem != null) {
                              Get.toNamed(
                                AppRoutes.subscriptionCart,
                                arguments: {'cartItem': cartItem},
                              );
                            }
                          }
                        : null,
                    icon: const Icon(Icons.chevron_right, size: 20),
                    label: Text(
                      'Continue',
                      style: AppTextStyles.button.copyWith(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.backgroundWhite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxl,
                        vertical: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: AppSpacing.md),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subscription mode',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pay monthly',
                        style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Switch(
                    value: controller.payMonthly.value,
                    onChanged: (_) => controller.togglePayMonthly(),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

