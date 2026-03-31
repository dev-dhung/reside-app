import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  int _expandedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return BaseScaffold(
      title: l10n.rulesTitle,
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        children: [
          // Banner: organic rounded shape
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primarySurface,
                  AppColors.primarySurface.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Subtle decorative circle
                Positioned(
                  top: -15,
                  right: -15,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.06),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.18),
                            AppColors.primary.withValues(alpha: 0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
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
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Rules list with accent when expanded
          ...List.generate(mockRules.length, (index) {
            final rule = mockRules[index];
            final isExpanded = _expandedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(
                  bottom: AppDimensions.paddingSmall),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                  border: isExpanded
                      ? Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 1.5,
                        )
                      : null,
                ),
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
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _expandedIndex = expanded ? index : -1;
                        });
                      },
                      trailing: AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: isExpanded
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          size: AppDimensions.iconMedium,
                        ),
                      ),
                      title: Row(
                        children: [
                          // Accent dot when expanded
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: isExpanded ? 8 : 0,
                            height: 8,
                            margin: EdgeInsets.only(
                              right: isExpanded
                                  ? AppDimensions.paddingSmall
                                  : 0,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              rule.category,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: AppDimensions.fontMedium,
                                color: isExpanded
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
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
              ),
            );
          }),
        ],
      ),
    );
  }
}
