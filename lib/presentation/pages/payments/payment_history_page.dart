import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/domain/entities/payment.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/data/datasources/mock/mock_all_payments.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class PaymentHistoryPage extends StatefulWidget {
  final bool isAdmin;

  const PaymentHistoryPage({super.key, this.isAdmin = false});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage>
    with SingleTickerProviderStateMixin {
  PaymentStatus? _statusFilter;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animController.dispose();
    super.dispose();
  }

  List<Payment> get _payments {
    List<Payment> source =
        widget.isAdmin ? mockAllPayments : mockPayments;

    if (_statusFilter != null) {
      source = source.where((p) => p.status == _statusFilter).toList();
    }

    if (widget.isAdmin && _searchQuery.isNotEmpty) {
      source = source.where((p) {
        final apt = userApartmentMap[p.userId] ?? '';
        return apt.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    source = List.from(source)..sort((a, b) => b.date.compareTo(a.date));
    return source;
  }

  double _totalByStatus(PaymentStatus status) {
    final source = widget.isAdmin ? mockAllPayments : mockPayments;
    return source
        .where((p) => p.status == status)
        .fold(0.0, (sum, p) => sum + p.amount);
  }

  int get _morosityCount {
    final source = mockAllPayments;
    return source
        .where((p) => p.status == PaymentStatus.rejected)
        .map((p) => p.userId)
        .toSet()
        .length;
  }

  // --- Method icon & color mapping ---

  IconData _methodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.transfer:
        return Icons.account_balance_rounded;
      case PaymentMethod.mobilePay:
        return Icons.phone_android_rounded;
      case PaymentMethod.zelle:
        return Icons.currency_exchange_rounded;
      case PaymentMethod.cash:
        return Icons.payments_rounded;
    }
  }

  Color _methodColor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.transfer:
        return const Color(0xFF5B9BD5); // blue
      case PaymentMethod.mobilePay:
        return const Color(0xFF9B72CF); // purple
      case PaymentMethod.zelle:
        return const Color(0xFF52B788); // green
      case PaymentMethod.cash:
        return const Color(0xFFE5A54B); // orange
    }
  }

  Color _statusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.approved:
        return AppColors.success;
      case PaymentStatus.pending:
        return AppColors.warning;
      case PaymentStatus.rejected:
        return AppColors.error;
    }
  }

  String _statusLabel(PaymentStatus status, L10n l10n) {
    switch (status) {
      case PaymentStatus.approved:
        return l10n.statusApproved;
      case PaymentStatus.pending:
        return l10n.statusPending;
      case PaymentStatus.rejected:
        return l10n.statusRejected;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // =========================================================================
  // BUILD
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          _buildWaveHeader(l10n),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: AppDimensions.paddingMedium),
                  _buildSummaryCard(l10n),
                  const SizedBox(height: AppDimensions.paddingLarge),
                  if (widget.isAdmin) ...[
                    _buildSearchBar(l10n),
                    const SizedBox(height: AppDimensions.paddingMedium),
                  ],
                  _buildFilterPills(l10n),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  _buildPaymentList(l10n),
                  const SizedBox(height: AppDimensions.paddingXXL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // WAVE HEADER
  // =========================================================================

  Widget _buildWaveHeader(L10n l10n) {
    return WaveHeader(
      height: 140,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textOnPrimary,
                size: AppDimensions.iconMedium,
              ),
              splashRadius: 24,
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                color: AppColors.textOnPrimary,
                size: AppDimensions.iconSmall,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall + 4),
            Expanded(
              child: Text(
                widget.isAdmin
                    ? l10n.paymentHistoryAdminTitle
                    : l10n.paymentHistoryResidentTitle,
                style: const TextStyle(
                  fontSize: AppDimensions.fontLarge,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textOnPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // SUMMARY CARD
  // =========================================================================

  Widget _buildSummaryCard(L10n l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      child: widget.isAdmin ? _buildAdminSummary(l10n) : _buildResidentSummary(l10n),
    );
  }

  Widget _buildResidentSummary(L10n l10n) {
    final totalPaid = _totalByStatus(PaymentStatus.approved);
    final totalPending = _totalByStatus(PaymentStatus.pending);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingXL,
            vertical: AppDimensions.paddingXL,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.gradientPrimary,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.30),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.totalPaid,
                style: TextStyle(
                  fontSize: AppDimensions.fontBody,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textOnPrimary.withValues(alpha: 0.80),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXS),
              Text(
                '\$${totalPaid.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontHero,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textOnPrimary,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSmall + 4,
                  vertical: AppDimensions.paddingXS + 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.warning.withValues(alpha: 0.5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${l10n.pending}: \$${totalPending.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textOnPrimary.withValues(alpha: 0.90),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Decorative circles
        Positioned(
          top: -18,
          right: -12,
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
        ),
        Positioned(
          bottom: -10,
          right: 40,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminSummary(L10n l10n) {
    final collected = _totalByStatus(PaymentStatus.approved);
    final pendingAmt = _totalByStatus(PaymentStatus.pending);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2D6A4F), Color(0xFF52B788)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.30),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _adminStatBox(
                  l10n.collectedThisMonth,
                  '\$${collected.toStringAsFixed(0)}',
                  AppColors.success,
                  Icons.trending_up_rounded,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              Expanded(
                child: _adminStatBox(
                  l10n.toCollect,
                  '\$${pendingAmt.toStringAsFixed(0)}',
                  AppColors.warning,
                  Icons.schedule_rounded,
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withValues(alpha: 0.15),
              ),
              Expanded(
                child: _adminStatBox(
                  l10n.defaulters,
                  '$_morosityCount',
                  AppColors.error,
                  Icons.person_off_rounded,
                ),
              ),
            ],
          ),
        ),
        // Decorative circle
        Positioned(
          top: -20,
          right: -14,
          child: Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),
      ],
    );
  }

  Widget _adminStatBox(
    String label,
    String value,
    Color indicator,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: indicator.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Icon(icon, size: 16, color: Colors.white),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppDimensions.fontXL,
            fontWeight: FontWeight.w800,
            color: AppColors.textOnPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppDimensions.fontXS,
            fontWeight: FontWeight.w500,
            color: AppColors.textOnPrimary.withValues(alpha: 0.75),
            height: 1.2,
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // SEARCH BAR (admin only)
  // =========================================================================

  Widget _buildSearchBar(L10n l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (val) => setState(() => _searchQuery = val),
          style: const TextStyle(
            fontSize: AppDimensions.fontBody,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: '${l10n.searchByApartment}  (${l10n.searchHintApt})',
            hintStyle: const TextStyle(
              fontSize: AppDimensions.fontSmall,
              color: AppColors.textTertiary,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 8),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.textTertiary,
                size: AppDimensions.iconSmall,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: AppColors.textTertiary,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // FILTER PILLS
  // =========================================================================

  Widget _buildFilterPills(L10n l10n) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
        ),
        children: [
          _filterPill(l10n.filterAll, null),
          const SizedBox(width: AppDimensions.paddingSmall),
          _filterPill(l10n.filterApproved, PaymentStatus.approved),
          const SizedBox(width: AppDimensions.paddingSmall),
          _filterPill(l10n.filterPending, PaymentStatus.pending),
          const SizedBox(width: AppDimensions.paddingSmall),
          _filterPill(l10n.filterRejected, PaymentStatus.rejected),
        ],
      ),
    );
  }

  Widget _filterPill(String label, PaymentStatus? status) {
    final isSelected = _statusFilter == status;
    return GestureDetector(
      onTap: () => setState(() => _statusFilter = status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium + 4,
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.inputBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppDimensions.fontSmall,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // PAYMENT LIST
  // =========================================================================

  Widget _buildPaymentList(L10n l10n) {
    final payments = _payments;

    if (payments.isEmpty) {
      return _buildEmptyState(l10n);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      child: Column(
        children: [
          for (int i = 0; i < payments.length; i++) ...[
            _buildPaymentCard(payments[i], l10n),
            if (i < payments.length - 1)
              const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(L10n l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingHero),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: AppDimensions.iconHero,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              l10n.noPaymentsMatch,
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // PAYMENT CARD
  // =========================================================================

  Widget _buildPaymentCard(Payment payment, L10n l10n) {
    final methodColor = _methodColor(payment.method);
    final statusCol = _statusColor(payment.status);
    final statusText = _statusLabel(payment.status, l10n);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        children: [
          Row(
            children: [
              // Method icon in colored rounded-square
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: methodColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Icon(
                  _methodIcon(payment.method),
                  size: AppDimensions.iconSmall,
                  color: methodColor,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingSmall + 4),
              // Center: description + date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.description ?? l10n.defaultPaymentDesc,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontBody,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          _formatDate(payment.date),
                          style: const TextStyle(
                            fontSize: AppDimensions.fontSmall,
                            color: AppColors.textTertiary,
                          ),
                        ),
                        if (widget.isAdmin) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: const BoxDecoration(
                              color: AppColors.textTertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.aptLabel(
                              userApartmentMap[payment.userId] ?? 'N/A',
                            ),
                            style: const TextStyle(
                              fontSize: AppDimensions.fontSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimensions.paddingSmall),
              // Right: amount + status badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${payment.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: AppDimensions.fontMedium,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: statusCol.withValues(alpha: 0.10),
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusPill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: statusCol,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: AppDimensions.fontXS,
                            fontWeight: FontWeight.w600,
                            color: statusCol,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Reference row
          const SizedBox(height: AppDimensions.paddingSmall),
          Row(
            children: [
              const SizedBox(width: 56), // align with content after icon
              Text(
                l10n.refLabel(payment.reference),
                style: TextStyle(
                  fontSize: AppDimensions.fontXS,
                  color: AppColors.textTertiary.withValues(alpha: 0.70),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
