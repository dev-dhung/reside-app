import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  ImageProvider _loadImage(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return BaseScaffold(
      title: l10n.creditsTitle,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.teamMembersSection,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontXL,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXS),
                  Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Team grid: clean white cards with avatar circles
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppDimensions.paddingSmall + 4,
                      mainAxisSpacing: AppDimensions.paddingSmall + 4,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: mockTeamMembers.length,
                    itemBuilder: (context, index) {
                      return _buildMemberCard(
                          context, mockTeamMembers[index]);
                    },
                  ),
                  const SizedBox(height: AppDimensions.paddingXXL),

                  // Tutor section
                  Text(
                    l10n.tutorSection,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontXL,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXS),
                  Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Tutor: elegant card with row layout
                  AppCard(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundImage:
                              _loadImage(mockTutor['image'] ?? ''),
                          backgroundColor: AppColors.primarySurface,
                          onBackgroundImageError: (_, _) {},
                        ),
                        const SizedBox(
                            width: AppDimensions.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                mockTutor['name'] ?? '',
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontLarge,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(
                                  height: AppDimensions.paddingXS),
                              Text(
                                mockTutor['role'] ?? '',
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontBody,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                mockTutor['titulo'] ?? '',
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontBody,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                mockTutor['phone'] ?? '',
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontBody,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),
                ],
              ),
            ),
          ),

          // Footer: minimal copyright
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingMedium,
              horizontal: AppDimensions.paddingLarge,
            ),
            child: Center(
              child: Text(
                l10n.copyrightNotice,
                style: const TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: AppDimensions.fontSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context,
    Map<String, String> member,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusXL),
              ),
              title: Text(
                L10n.of(context).profileOf(member['name'] ?? ''),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppDimensions.fontLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium),
                    child: Image(
                      image:
                          _loadImage(member['qr_image'] ?? ''),
                      width: 200,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 200),
                    ),
                  ),
                  const SizedBox(
                      height: AppDimensions.paddingSmall + 2),
                  Text(
                    L10n.of(context).scanProfile,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimensions.fontBody,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    L10n.of(context).closeButton,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
          horizontal: AppDimensions.paddingSmall,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage:
                  _loadImage(member['image'] ?? ''),
              backgroundColor: AppColors.primarySurface,
              onBackgroundImageError: (_, _) {},
            ),
            const SizedBox(
                height: AppDimensions.paddingSmall + 4),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXS,
              ),
              child: Text(
                member['name'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppDimensions.fontBody,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXS,
              ),
              child: Text(
                member['role'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
