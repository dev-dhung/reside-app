import 'package:flutter/material.dart';
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

class SigraApp extends StatelessWidget {
  const SigraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGRA - La Molienda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: const Locale('es'),
      initialRoute: AppRoutes.login,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return _buildRoute(const LoginPage(), settings);
      case AppRoutes.register:
        return _buildRoute(const RegisterPage(), settings);
      case AppRoutes.home:
        return _buildRoute(const MainShell(), settings);
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
