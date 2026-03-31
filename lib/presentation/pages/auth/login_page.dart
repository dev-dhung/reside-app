import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // -- Top Section: Logo & Branding --
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimensions.paddingHero,
                  ),
                  child: Column(
                    children: [
                      // Decorative green circle with icon
                      Container(
                        width: AppDimensions.avatarHero,
                        height: AppDimensions.avatarHero,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.25),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.apartment,
                          size: AppDimensions.iconXL,
                          color: AppColors.textOnPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),
                      // App name
                      Text(
                        l10n.appName,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontHero,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      // Subtitle
                      Text(
                        l10n.appSubtitle,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          color: AppColors.textSecondary,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                // -- Bottom Section: Form --
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingXXL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppDimensions.paddingHero),
                      // Welcome text
                      Text(
                        l10n.welcomeMessage,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontXL,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),
                      // Apartment field
                      AppTextField(
                        label: l10n.apartmentLabel,
                        prefixIcon: const Icon(
                          Icons.home_outlined,
                          color: AppColors.textTertiary,
                          size: AppDimensions.iconSmall,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      // Password field
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
                      // Login button
                      AppButton(
                        label: l10n.loginButton,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.home,
                          );
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      // Register link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                          child: Text(
                            l10n.registerLink,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontBody,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // -- Footer --
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.paddingLarge,
                    top: AppDimensions.paddingMedium,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.credits);
                    },
                    child: Text(
                      l10n.developedBy,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.textTertiary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
