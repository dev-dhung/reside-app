import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = 'transfer';

  final _referenceController = TextEditingController();
  final _amountController = TextEditingController();

  static const List<String> _paymentMethodKeys = [
    'transfer',
    'mobilePay',
    'zelle',
    'cash',
  ];

  static const Map<String, IconData> _methodIcons = {
    'transfer': Icons.account_balance_rounded,
    'mobilePay': Icons.phone_android_rounded,
    'zelle': Icons.bolt_rounded,
    'cash': Icons.payments_rounded,
  };

  String _methodLabel(L10n l10n, String key) {
    switch (key) {
      case 'transfer':
        return l10n.methodTransfer;
      case 'mobilePay':
        return l10n.methodMobilePay;
      case 'zelle':
        return l10n.methodZelle;
      case 'cash':
        return l10n.methodCash;
      default:
        return key;
    }
  }

  @override
  void dispose() {
    _referenceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final l10n = L10n.of(context);
    showDialog(
      context: context,
      barrierColor: AppColors.overlay,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        backgroundColor: AppColors.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingXXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppDimensions.iconHero,
                height: AppDimensions.iconHero,
                decoration: const BoxDecoration(
                  color: AppColors.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.primary,
                  size: AppDimensions.iconLarge,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingLarge),
              Text(
                l10n.paymentSuccessMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppDimensions.fontMedium,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXL),
              AppButton(
                label: l10n.understoodButton,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return BaseScaffold(
      title: l10n.paymentTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingMedium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Text(
              l10n.transactionDetails,
              style: const TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXL),

            // Payment method label
            Text(
              l10n.paymentMethodLabel,
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),

            // Payment method pill chips
            Wrap(
              spacing: AppDimensions.paddingSmall,
              runSpacing: AppDimensions.paddingSmall,
              children: _paymentMethodKeys.map((key) {
                final isSelected = _selectedMethod == key;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMethod = key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingSmall + 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.inputBackground,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusPill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _methodIcons[key],
                          size: AppDimensions.iconXS,
                          color: isSelected
                              ? AppColors.textOnPrimary
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _methodLabel(l10n, key),
                          style: TextStyle(
                            fontSize: AppDimensions.fontSmall,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.textOnPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),

            // Reference field
            AppTextField(
              label: l10n.referenceNumberLabel,
              controller: _referenceController,
              prefixIcon: const Icon(
                Icons.tag_rounded,
                size: AppDimensions.iconSmall,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),

            // Amount field
            AppTextField(
              label: l10n.amountLabel,
              controller: _amountController,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(
                Icons.attach_money_rounded,
                size: AppDimensions.iconSmall,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),

            // Upload area with dashed border
            GestureDetector(
              onTap: () {
                // TODO: implement image picker
              },
              child: CustomPaint(
                painter: _DashedBorderPainter(
                  color: AppColors.textTertiary,
                  radius: AppDimensions.radiusLarge,
                  strokeWidth: 1.5,
                  dashWidth: 8,
                  dashSpace: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusLarge),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppColors.primarySurface,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: AppDimensions.iconMedium,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      Text(
                        l10n.attachReceipt,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXXL),

            // Submit button
            AppButton(
              label: l10n.sendReportButton,
              onPressed: _onSubmit,
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for dashed border
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics().first;
    final totalLength = metrics.length;
    double distance = 0;

    while (distance < totalLength) {
      final end = min(distance + dashWidth, totalLength);
      canvas.drawPath(
        metrics.extractPath(distance, end),
        paint,
      );
      distance = end + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      radius != oldDelegate.radius ||
      strokeWidth != oldDelegate.strokeWidth;
}
