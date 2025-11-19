import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/asset_helper.dart';
import '../models/search_result.dart';

/// Search Result Item Widget
/// 
/// Displays a single search result (product or service).
class SearchResultItem extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const SearchResultItem({
    super.key,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (result.type == SearchResultType.service) {
      return _ServiceResultItem(result: result, onTap: onTap);
    } else {
      return _ProductResultItem(result: result, onTap: onTap);
    }
  }
}

class _ServiceResultItem extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const _ServiceResultItem({
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFDAE6ED),
                borderRadius: BorderRadius.circular(4),
              ),
              child: result.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: AssetHelper.loadImageOrPlaceholder(
                        assetPath: result.imageUrl!,
                        width: 72,
                        height: 72,
                      ),
                    )
                  : const Icon(
                      Icons.electrical_services,
                      size: 32,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(width: AppSpacing.md),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: AppTextStyles.bodySmall.copyWith(
                      letterSpacing: 0.24,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      if (result.rating != null) ...[
                        Text(
                          result.rating!.toStringAsFixed(1),
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.16,
                          ),
                        ),
                        const SizedBox(width: 2),
                        AssetHelper.loadImageOrIcon(
                          assetPath: 'assets/images/star_1.png',
                          fallbackIcon: Icons.star,
                          size: 8,
                          color: Colors.amber,
                        ),
                        if (result.bookings != null) ...[
                          const SizedBox(width: 2),
                          Text(
                            '(${result.bookings} bookings)',
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                  if (result.category != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      result.category!,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 8,
                        color: AppColors.primary,
                        letterSpacing: 0.16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            // Add button (for services)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Add',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: AppColors.backgroundWhite,
                  letterSpacing: 0.24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductResultItem extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const _ProductResultItem({
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Row(
          children: [
            // Image with rating badge
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.inputBorder,
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: Stack(
                children: [
                  result.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                          child: AssetHelper.loadImageOrPlaceholder(
                            assetPath: result.imageUrl!,
                            width: 72,
                            height: 72,
                          ),
                        )
                      : const Icon(
                          Icons.image,
                          size: 32,
                          color: Colors.grey,
                        ),
                  if (result.rating != null)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              result.rating!.toStringAsFixed(1),
                              style: AppTextStyles.caption.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.16,
                              ),
                            ),
                            const SizedBox(width: 2),
                            AssetHelper.loadImageOrIcon(
                              assetPath: 'assets/images/star_1.png',
                              fallbackIcon: Icons.star,
                              size: 8,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (result.category != null)
                    Text(
                      result.category!,
                      style: AppTextStyles.caption.copyWith(
                        fontSize: 8,
                        color: AppColors.primary,
                        letterSpacing: 0.16,
                      ),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    result.title,
                    style: AppTextStyles.bodySmall.copyWith(
                      letterSpacing: 0.24,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (result.price != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          result.price!.toStringAsFixed(2),
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.24,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'OMR',
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 8,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

