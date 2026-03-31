import 'package:flutter/material.dart';
import 'package:prototype/core/providers/settings_provider.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/core/theme/app_theme.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/pages/announcements/announcements_page.dart';
import 'package:prototype/presentation/pages/auth/login_page.dart';
import 'package:prototype/presentation/pages/auth/register_page.dart';
import 'package:prototype/presentation/pages/chatbot/chatbot_page.dart';
import 'package:prototype/presentation/pages/credits/credits_page.dart';
import 'package:prototype/presentation/pages/main_shell.dart';
import 'package:prototype/presentation/pages/payments/payment_page.dart';
import 'package:prototype/presentation/pages/profile/profile_page.dart';
import 'package:prototype/presentation/pages/reports/reports_page.dart';
import 'package:prototype/presentation/pages/reservations/reservations_page.dart';
import 'package:prototype/presentation/pages/rules/rules_page.dart';
import 'package:prototype/presentation/pages/visitors/visitors_page.dart';
import 'package:prototype/presentation/pages/maintenance/maintenance_page.dart';
import 'package:prototype/presentation/pages/voting/voting_page.dart';
import 'package:prototype/presentation/pages/payments/payment_history_page.dart';
import 'package:prototype/presentation/pages/emergency/emergency_page.dart';
import 'package:prototype/presentation/pages/profile/help_center_page.dart';
import 'package:prototype/presentation/pages/profile/contact_support_page.dart';
import 'package:prototype/presentation/pages/profile/change_password_page.dart';
import 'package:prototype/presentation/pages/profile/terms_page.dart';
import 'package:prototype/presentation/pages/profile/privacy_page.dart';

class SigraApp extends StatefulWidget {
  const SigraApp({super.key});

  /// Access the app state from anywhere in the widget tree.
  /// Usage: SigraApp.of(context)?.settings.toggleTheme()
  static SigraAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<SigraAppState>();

  @override
  State<SigraApp> createState() => SigraAppState();
}

class SigraAppState extends State<SigraApp> {
  final SettingsProvider settings = SettingsProvider();

  @override
  void initState() {
    super.initState();
    settings.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    settings.removeListener(_onSettingsChanged);
    settings.dispose();
    super.dispose();
  }

  void _onSettingsChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: MaterialApp(
          title: 'Reside',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          locale: settings.locale,
          initialRoute: AppRoutes.login,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _buildRoute(const LoginPage(), settings);
      case AppRoutes.register:
        return _buildRoute(const RegisterPage(), settings);
      case AppRoutes.home:
        final homeArgs = settings.arguments as Map<String, dynamic>?;
        final homeIsAdmin = homeArgs?['isAdmin'] as bool? ?? false;
        final homeUserName = homeArgs?['userName'] as String? ?? '';
        return _buildRoute(
          MainShell(isAdmin: homeIsAdmin, userName: homeUserName),
          settings,
        );
      case AppRoutes.payment:
        return _buildRoute(const PaymentPage(), settings);
      case AppRoutes.reservations:
        return _buildRoute(ReservationsPage(), settings);
      case AppRoutes.announcements:
        return _buildRoute(AnnouncementsPage(), settings);
      case AppRoutes.rules:
        return _buildRoute(RulesPage(), settings);
      case AppRoutes.profile:
        return _buildRoute(const ProfilePage(), settings);
      case AppRoutes.chatbot:
        return _buildRoute(const ChatbotPage(), settings);
      case AppRoutes.reports:
        final args = settings.arguments as Map<String, dynamic>?;
        final isAdmin = args?['soyAdmin'] as bool? ?? false;
        return _buildRoute(ReportsPage(isAdmin: isAdmin), settings);
      case AppRoutes.credits:
        return _buildRoute(CreditsPage(), settings);
      case AppRoutes.visitors:
        final args = settings.arguments as Map<String, dynamic>?;
        final isAdmin = args?['isAdmin'] as bool? ?? false;
        return _buildRoute(VisitorsPage(isAdmin: isAdmin), settings);
      case AppRoutes.maintenance:
        final args = settings.arguments as Map<String, dynamic>?;
        final isAdmin = args?['isAdmin'] as bool? ?? false;
        return _buildRoute(MaintenancePage(isAdmin: isAdmin), settings);
      case AppRoutes.voting:
        final args = settings.arguments as Map<String, dynamic>?;
        final isAdmin = args?['isAdmin'] as bool? ?? false;
        return _buildRoute(VotingPage(isAdmin: isAdmin), settings);
      case AppRoutes.paymentHistory:
        final args = settings.arguments as Map<String, dynamic>?;
        final isAdmin = args?['isAdmin'] as bool? ?? false;
        return _buildRoute(PaymentHistoryPage(isAdmin: isAdmin), settings);
      case AppRoutes.emergency:
        return _buildRoute(const EmergencyPage(), settings);
      case AppRoutes.helpCenter:
        return _buildRoute(const HelpCenterPage(), settings);
      case AppRoutes.contactSupport:
        return _buildRoute(const ContactSupportPage(), settings);
      case AppRoutes.changePassword:
        return _buildRoute(const ChangePasswordPage(), settings);
      case AppRoutes.terms:
        return _buildRoute(const TermsPage(), settings);
      case AppRoutes.privacy:
        return _buildRoute(const PrivacyPage(), settings);
      default:
        return _buildRoute(const LoginPage(), settings);
    }
  }

  MaterialPageRoute<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }
}
