import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textSecondary,
            size: AppDimensions.iconSmall,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.registerTitle,
          style: const TextStyle(
            fontSize: AppDimensions.fontMedium,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXXL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimensions.paddingXL),
            // Decorative icon
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_add_outlined,
                  size: AppDimensions.iconLarge,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXL),
            // Header
            Text(
              l10n.registerSubtitle,
              style: const TextStyle(
                fontSize: AppDimensions.fontTitle,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              l10n.registerDescription,
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXXL),
            // Full name
            AppTextField(
              label: l10n.fullNameLabel,
              prefixIcon: const Icon(
                Icons.person_outlined,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            // Cedula
            AppTextField(
              label: l10n.cedulaLabel,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(
                Icons.badge_outlined,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            // Tower / Apartment
            AppTextField(
              label: l10n.towerApartmentLabel,
              prefixIcon: const Icon(
                Icons.apartment_outlined,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            // Email
            AppTextField(
              label: l10n.emailLabel,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            // Password
            AppTextField(
              label: l10n.passwordLabel,
              obscureText: _obscurePassword,
              prefixIcon: const Icon(
                Icons.lock_outlined,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textTertiary,
                  size: AppDimensions.iconSmall,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXXL),
            // Register button
            AppButton(
              label: l10n.registerButton,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: AppDimensions.paddingHero),
          ],
        ),
      ),
    );
  }
}
