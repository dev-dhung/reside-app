import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return BaseScaffold(
      title: l10n.rulesTitle,
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        children: [
          // Banner: soft green card with gavel icon
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusXL),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.gavel,
                    color: AppColors.primary,
                    size: AppDimensions.iconMedium,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                Expanded(
                  child: Text(
                    l10n.rulesBanner,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontBody,
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Rules list: white card per rule
          ...mockRules.map((rule) => Padding(
                padding: const EdgeInsets.only(
                    bottom: AppDimensions.paddingSmall),
                child: AppCard(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      childrenPadding: const EdgeInsets.only(
                        top: AppDimensions.paddingSmall,
                      ),
                      expandedCrossAxisAlignment:
                          CrossAxisAlignment.start,
                      trailing: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textTertiary,
                        size: AppDimensions.iconMedium,
                      ),
                      title: Text(
                        rule.category,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppDimensions.fontMedium,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      children: [
                        Divider(
                          color: AppColors.divider,
                          height: 1,
                        ),
                        const SizedBox(
                            height: AppDimensions.paddingSmall),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: AppDimensions.paddingXS),
                          child: Text(
                            rule.detail,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontBody,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
