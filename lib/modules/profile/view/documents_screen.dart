import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/typography.dart';

/// Documents Screen
/// 
/// Lists user's uploaded documents.
/// Design Source: Figma frame "Document" (node-id: 1-25592)
class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock documents data
    final documents = [
      {
        'name': 'Driving License',
        'image': 'assets/documents/driving_license.png',
        'isUploaded': true,
      },
      {
        'name': 'Oman National ID',
        'image': null,
        'isUploaded': false,
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
          'Documents',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.figtree,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(25),
        itemCount: documents.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final document = documents[index];
          return _DocumentItem(
            name: document['name'] as String,
            image: document['image'] as String?,
            isUploaded: document['isUploaded'] as bool,
            onView: () {
              // TODO: View document
            },
            onEdit: () {
              // TODO: Edit document
            },
            onUpload: () {
              // TODO: Upload document
            },
          );
        },
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  final String name;
  final String? image;
  final bool isUploaded;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onUpload;

  const _DocumentItem({
    required this.name,
    this.image,
    required this.isUploaded,
    required this.onView,
    required this.onEdit,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Document Thumbnail
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: image != null ? null : const Color(0xFFE7EBF4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.description, size: 32);
                      },
                    ),
                  )
                : const Icon(Icons.description, size: 32, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 8),
          // Document Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (!isUploaded) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Tap to Upload',
                    style: AppTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: AppColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Action Buttons
          Row(
            children: [
              if (isUploaded) ...[
                IconButton(
                  icon: Image.asset(
                    'assets/documents/maximize_icon.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.fullscreen, size: 16);
                    },
                  ),
                  onPressed: onView,
                ),
                IconButton(
                  icon: Image.asset(
                    'assets/profile/edit_icon.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.edit, size: 16);
                    },
                  ),
                  onPressed: onEdit,
                ),
              ] else
                IconButton(
                  icon: Image.asset(
                    'assets/documents/upload_icon.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.upload, size: 16);
                    },
                  ),
                  onPressed: onUpload,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

