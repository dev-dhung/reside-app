import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/domain/entities/payment.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/data/datasources/mock/mock_all_payments.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class PaymentHistoryPage extends StatefulWidget {
  final bool isAdmin;

  const PaymentHistoryPage({super.key, this.isAdmin = false});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  PaymentStatus? _statusFilter;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return BaseScaffold(
      title: widget.isAdmin
          ? l10n.paymentHistoryAdminTitle
          : l10n.paymentHistoryResidentTitle,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: _buildSummaryCard(l10n),
          ),
          if (widget.isAdmin)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusPill),
                ),
                child: AppTextField(
                  label: l10n.searchByApartment,
                  hintText: l10n.searchHintApt,
                  controller: _searchController,
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textTertiary),
                  onSubmitted: (val) {
                    setState(() => _searchQuery = val);
                  },
                ),
              ),
            ),
          if (widget.isAdmin)
            const SizedBox(height: AppDimensions.paddingMedium),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium),
            child: _buildFilterChips(l10n),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Expanded(child: _buildPaymentList(l10n)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(L10n l10n) {
    final gradientColors = widget.isAdmin
        ? AppColors.gradientAccent
        : AppColors.gradientPrimary;

    if (widget.isAdmin) {
      final collected = _totalByStatus(PaymentStatus.approved);
      final pendingAmt = _totalByStatus(PaymentStatus.pending);
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingXL,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _summaryItem(l10n.collectedThisMonth,
                '\$${collected.toStringAsFixed(0)}', AppColors.textOnAccent),
            Container(
                width: 1,
                height: 40,
                color: AppColors.textOnAccent.withValues(alpha: 0.2)),
            _summaryItem(l10n.toCollect,
                '\$${pendingAmt.toStringAsFixed(0)}', AppColors.textOnAccent),
            Container(
                width: 1,
                height: 40,
                color: AppColors.textOnAccent.withValues(alpha: 0.2)),
            _summaryItem(
                l10n.defaulters, '$_morosityCount', AppColors.textOnAccent),
          ],
        ),
      );
    }

    final totalPaid = _totalByStatus(PaymentStatus.approved);
    final totalPending = _totalByStatus(PaymentStatus.pending);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingXL,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _summaryItem(l10n.totalPaid,
              '\$${totalPaid.toStringAsFixed(0)}', AppColors.textOnPrimary),
          Container(
              width: 1,
              height: 40,
              color: AppColors.textOnPrimary.withValues(alpha: 0.25)),
          _summaryItem(l10n.pending,
              '\$${totalPending.toStringAsFixed(0)}', AppColors.textOnPrimary),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: AppDimensions.fontXL,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppDimensions.fontSmall,
            fontWeight: FontWeight.w500,
            color: color.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(L10n l10n) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip(l10n.filterAll, null),
          const SizedBox(width: AppDimensions.paddingSmall),
          _chip(l10n.filterApproved, PaymentStatus.approved),
          const SizedBox(width: AppDimensions.paddingSmall),
          _chip(l10n.filterPending, PaymentStatus.pending),
          const SizedBox(width: AppDimensions.paddingSmall),
          _chip(l10n.filterRejected, PaymentStatus.rejected),
        ],
      ),
    );
  }

  Widget _chip(String label, PaymentStatus? status) {
    final isSelected = _statusFilter == status;
    return GestureDetector(
      onTap: () => setState(() => _statusFilter = status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          boxShadow: isSelected
              ? null
              : const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppDimensions.fontSmall,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentList(L10n l10n) {
    final payments = _payments;
    if (payments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.receipt_long_outlined,
                  size: AppDimensions.iconXL, color: AppColors.textTertiary),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              l10n.noPaymentsMatch,
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall,
      ),
      itemCount: payments.length,
      itemBuilder: (_, i) => _buildPaymentItem(payments[i]),
    );
  }

  Widget _buildPaymentItem(Payment payment) {
    final l10n = L10n.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left color indicator
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: _statusColor(payment.status),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.radiusXL),
                    bottomLeft: Radius.circular(AppDimensions.radiusXL),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Method icon in circle
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _methodIcon(payment.method),
                              size: AppDimensions.iconSmall,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingSmall + 4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payment.description ??
                                      l10n.defaultPaymentDesc,
                                  style: const TextStyle(
                                    fontSize: AppDimensions.fontBody,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _formatDate(payment.date),
                                  style: const TextStyle(
                                    fontSize: AppDimensions.fontSmall,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$${payment.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontMedium,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppDimensions.paddingXS),
                              _paymentStatusBadge(payment.status),
                            ],
                          ),
                        ],
                      ),
                      if (widget.isAdmin) ...[
                        const SizedBox(height: AppDimensions.paddingSmall),
                        Row(
                          children: [
                            const Icon(Icons.apartment,
                                size: AppDimensions.iconSmall,
                                color: AppColors.textSecondary),
                            const SizedBox(width: AppDimensions.paddingXS),
                            Text(
                              l10n.aptLabel(
                                  userApartmentMap[payment.userId] ?? 'N/A'),
                              style: const TextStyle(
                                fontSize: AppDimensions.fontSmall,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              l10n.refLabel(payment.reference),
                              style: const TextStyle(
                                fontSize: AppDimensions.fontSmall,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _methodIcon(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.transfer:
        return Icons.account_balance;
      case PaymentMethod.mobilePay:
        return Icons.phone_android;
      case PaymentMethod.zelle:
        return Icons.attach_money;
      case PaymentMethod.cash:
        return Icons.payments;
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

  Widget _paymentStatusBadge(PaymentStatus status) {
    final l10n = L10n.of(context);
    switch (status) {
      case PaymentStatus.approved:
        return StatusBadge(
            label: l10n.statusApproved, color: AppColors.success);
      case PaymentStatus.pending:
        return StatusBadge(
            label: l10n.statusPending, color: AppColors.warning);
      case PaymentStatus.rejected:
        return StatusBadge(
            label: l10n.statusRejected, color: AppColors.error);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
