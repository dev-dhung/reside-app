import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_visitors.dart';
import 'package:prototype/domain/entities/visitor.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class VisitorsPage extends StatefulWidget {
  final bool isAdmin;

  const VisitorsPage({super.key, this.isAdmin = false});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  late List<Visitor> _visitors;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  L10n get l10n => L10n.of(context);

  @override
  void initState() {
    super.initState();
    _visitors = List.from(mockVisitors);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Visitor> get _filteredVisitors {
    List<Visitor> list;
    if (widget.isAdmin) {
      list = _visitors;
    } else {
      list = _visitors.where((v) => v.residentId == 'usr-001').toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      list = list
          .where((v) =>
              v.visitorName.toLowerCase().contains(query) ||
              v.residentApartment.toLowerCase().contains(query))
          .toList();
    }

    list.sort((a, b) {
      if (a.status == VisitorStatus.pending &&
          b.status != VisitorStatus.pending) {
        return -1;
      }
      if (b.status == VisitorStatus.pending &&
          a.status != VisitorStatus.pending) {
        return 1;
      }
      return b.expectedDate.compareTo(a.expectedDate);
    });

    return list;
  }

  String _statusLabel(VisitorStatus status) {
    switch (status) {
      case VisitorStatus.pending:
        return l10n.visitorStatusPending;
      case VisitorStatus.approved:
        return l10n.visitorStatusApproved;
      case VisitorStatus.inBuilding:
        return l10n.visitorStatusInBuilding;
      case VisitorStatus.exited:
        return l10n.visitorStatusExited;
      case VisitorStatus.rejected:
        return l10n.visitorStatusRejected;
    }
  }

  static Color _statusColor(VisitorStatus status) {
    switch (status) {
      case VisitorStatus.pending:
        return AppColors.warning;
      case VisitorStatus.approved:
        return AppColors.success;
      case VisitorStatus.inBuilding:
        return AppColors.info;
      case VisitorStatus.exited:
        return AppColors.textTertiary;
      case VisitorStatus.rejected:
        return AppColors.error;
    }
  }

  static IconData _statusIcon(VisitorStatus status) {
    switch (status) {
      case VisitorStatus.pending:
        return Icons.hourglass_empty;
      case VisitorStatus.approved:
        return Icons.check_circle_outline;
      case VisitorStatus.inBuilding:
        return Icons.login;
      case VisitorStatus.exited:
        return Icons.logout;
      case VisitorStatus.rejected:
        return Icons.cancel_outlined;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  int get _todayCount {
    final now = DateTime.now();
    return _visitors
        .where((v) =>
            v.expectedDate.year == now.year &&
            v.expectedDate.month == now.month &&
            v.expectedDate.day == now.day)
        .length;
  }

  int get _inBuildingCount =>
      _visitors.where((v) => v.status == VisitorStatus.inBuilding).length;

  int get _pendingCount =>
      _visitors.where((v) => v.status == VisitorStatus.pending).length;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.isAdmin
          ? l10n.visitorsAdminTitle
          : l10n.visitorsResidentTitle,
      floatingActionButton: widget.isAdmin
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () => _showRegisterSheet(context),
              child:
                  const Icon(Icons.person_add, color: AppColors.textOnPrimary),
            ),
      body: Column(
        children: [
          if (widget.isAdmin) ...[
            _buildSearchBar(),
            _buildStatsRow(),
          ],
          Expanded(child: _buildVisitorList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onSubmitted: (_) {
            setState(() => _searchQuery = _searchController.text);
          },
          decoration: InputDecoration(
            hintText: l10n.searchVisitorHint,
            hintStyle: const TextStyle(
              color: AppColors.textTertiary,
              fontSize: AppDimensions.fontBody,
            ),
            prefixIcon:
                const Icon(Icons.search, color: AppColors.textTertiary),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear,
                        color: AppColors.textTertiary),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall + 4,
      ),
      child: Row(
        children: [
          Expanded(
              child: _statMiniCard(
                  l10n.todayLabel, _todayCount, AppColors.primary)),
          const SizedBox(width: AppDimensions.paddingSmall),
          Expanded(
              child: _statMiniCard(
                  l10n.inBuildingLabel, _inBuildingCount, AppColors.info)),
          const SizedBox(width: AppDimensions.paddingSmall),
          Expanded(
              child: _statMiniCard(
                  l10n.pendingLabel, _pendingCount, AppColors.warning)),
        ],
      ),
    );
  }

  Widget _statMiniCard(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Organic colored dot on top
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXS),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: AppDimensions.fontXL,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXS),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppDimensions.fontSmall,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisitorList() {
    final visitors = _filteredVisitors;

    if (visitors.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.people_outline,
                  size: AppDimensions.iconXL, color: AppColors.textTertiary),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              widget.isAdmin
                  ? l10n.noVisitorsFound
                  : l10n.noVisitorsRegistered,
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
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      itemCount: visitors.length,
      itemBuilder: (context, index) {
        final visitor = visitors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
          child: widget.isAdmin
              ? _buildAdminCard(visitor)
              : _buildResidentCard(visitor),
        );
      },
    );
  }

  Widget _buildResidentCard(Visitor visitor) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primarySurface,
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: AppDimensions.iconSmall,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingSmall + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      visitor.visitorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.fontMedium,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${visitor.visitorCedula}  |  ${_formatDate(visitor.expectedDate)}',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: _statusLabel(visitor.status),
                color: _statusColor(visitor.status),
              ),
            ],
          ),
          if (visitor.vehiclePlate != null) ...[
            const SizedBox(height: AppDimensions.paddingSmall),
            Row(
              children: [
                const Icon(Icons.directions_car,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: AppDimensions.paddingXS),
                Text(
                  visitor.vehiclePlate!,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
          if (visitor.notes != null && visitor.notes!.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.paddingXS),
            Row(
              children: [
                const Icon(Icons.note_outlined,
                    size: 16, color: AppColors.textSecondary),
                const SizedBox(width: AppDimensions.paddingXS),
                Flexible(
                  child: Text(
                    visitor.notes!,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontSmall,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (visitor.status == VisitorStatus.approved ||
              visitor.status == VisitorStatus.inBuilding) ...[
            const SizedBox(height: AppDimensions.paddingSmall + 4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
                vertical: AppDimensions.paddingSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.qr_code,
                      size: 18, color: AppColors.primary),
                  const SizedBox(width: AppDimensions.paddingSmall),
                  Text(
                    l10n.accessCodeLabel(visitor.accessCode),
                    style: const TextStyle(
                      fontSize: AppDimensions.fontBody,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAdminCard(Visitor visitor) {
    final isPending = visitor.status == VisitorStatus.pending;

    return AppCard(
      onTap: isPending ? () => _showAdminActions(context, visitor) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    _statusColor(visitor.status).withValues(alpha: 0.1),
                child: Icon(
                  _statusIcon(visitor.status),
                  color: _statusColor(visitor.status),
                  size: AppDimensions.iconSmall,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingSmall + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      visitor.visitorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppDimensions.fontMedium,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Apto ${visitor.residentApartment}  |  ${visitor.visitorCedula}',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: _statusLabel(visitor.status),
                color: _statusColor(visitor.status),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 14, color: AppColors.textSecondary),
              const SizedBox(width: AppDimensions.paddingXS),
              Text(
                _formatDate(visitor.expectedDate),
                style: const TextStyle(
                  fontSize: AppDimensions.fontSmall,
                  color: AppColors.textSecondary,
                ),
              ),
              if (visitor.entryTime != null) ...[
                const SizedBox(width: AppDimensions.paddingMedium),
                const Icon(Icons.login, size: 14, color: AppColors.info),
                const SizedBox(width: AppDimensions.paddingXS),
                Text(
                  _formatTime(visitor.entryTime!),
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.info,
                  ),
                ),
              ],
              if (visitor.exitTime != null) ...[
                const SizedBox(width: AppDimensions.paddingMedium),
                const Icon(Icons.logout,
                    size: 14, color: AppColors.textTertiary),
                const SizedBox(width: AppDimensions.paddingXS),
                Text(
                  _formatTime(visitor.exitTime!),
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
              if (visitor.vehiclePlate != null) ...[
                const Spacer(),
                const Icon(Icons.directions_car,
                    size: 14, color: AppColors.textSecondary),
                const SizedBox(width: AppDimensions.paddingXS),
                Text(
                  visitor.vehiclePlate!,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          if (isPending) ...[
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: l10n.approveButton,
                    icon: Icons.check,
                    backgroundColor: AppColors.success,
                    height: 38,
                    onPressed: () => _confirmAction(
                      context,
                      visitor,
                      true,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Expanded(
                  child: AppButton(
                    label: l10n.rejectButton,
                    icon: Icons.close,
                    backgroundColor: AppColors.error,
                    height: 38,
                    onPressed: () => _confirmAction(
                      context,
                      visitor,
                      false,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showAdminActions(BuildContext context, Visitor visitor) {
    _confirmAction(context, visitor, true);
  }

  void _confirmAction(
      BuildContext context, Visitor visitor, bool approve) {
    final action = approve
        ? l10n.approveButton.toLowerCase()
        : l10n.rejectButton.toLowerCase();
    final actionPast = approve
        ? l10n.visitorStatusApproved.toLowerCase()
        : l10n.visitorStatusRejected.toLowerCase();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        title: Text(
            approve ? l10n.approveVisitorTitle : l10n.rejectVisitorTitle),
        content: Text(
          l10n.visitorActionConfirm(
            action,
            visitor.visitorName,
            visitor.residentApartment,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                final index =
                    _visitors.indexWhere((v) => v.id == visitor.id);
                if (index != -1) {
                  final v = _visitors[index];
                  _visitors[index] = Visitor(
                    id: v.id,
                    residentId: v.residentId,
                    residentApartment: v.residentApartment,
                    visitorName: v.visitorName,
                    visitorCedula: v.visitorCedula,
                    expectedDate: v.expectedDate,
                    entryTime: v.entryTime,
                    exitTime: v.exitTime,
                    status: approve
                        ? VisitorStatus.approved
                        : VisitorStatus.rejected,
                    vehiclePlate: v.vehiclePlate,
                    notes: v.notes,
                    accessCode: v.accessCode,
                  );
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.visitorActionSuccess(actionPast)),
                  backgroundColor:
                      approve ? AppColors.success : AppColors.error,
                ),
              );
            },
            child: Text(
              approve ? l10n.approveButtonUpper : l10n.rejectButtonUpper,
              style: TextStyle(
                color: approve ? AppColors.success : AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegisterSheet(BuildContext context) {
    final nameCtrl = TextEditingController();
    final cedulaCtrl = TextEditingController();
    final plateCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXXL),
        ),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.paddingLarge,
                AppDimensions.paddingMedium,
                AppDimensions.paddingLarge,
                MediaQuery.of(ctx).viewInsets.bottom +
                    AppDimensions.paddingLarge,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Grab handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      Text(
                        l10n.registerVisitorTitle,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontXL,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),
                      AppTextField(
                        label: l10n.visitorNameLabel,
                        controller: nameCtrl,
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return l10n.visitorNameRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      AppTextField(
                        label: l10n.visitorCedulaLabel,
                        controller: cedulaCtrl,
                        prefixIcon: const Icon(Icons.badge_outlined),
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return l10n.visitorCedulaRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      InkWell(
                        borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: ctx,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 90)),
                          );
                          if (picked != null) {
                            setSheetState(() => selectedDate = picked);
                          }
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: l10n.expectedDateLabel,
                            prefixIcon:
                                const Icon(Icons.calendar_today_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMedium),
                              borderSide:
                                  const BorderSide(color: AppColors.divider),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusMedium),
                              borderSide:
                                  const BorderSide(color: AppColors.divider),
                            ),
                          ),
                          child: Text(
                            _formatDate(selectedDate),
                            style: const TextStyle(
                              fontSize: AppDimensions.fontBody,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      AppTextField(
                        label: l10n.vehiclePlateLabel,
                        controller: plateCtrl,
                        prefixIcon:
                            const Icon(Icons.directions_car_outlined),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      AppTextField(
                        label: l10n.notesOptionalLabel,
                        controller: notesCtrl,
                        prefixIcon: const Icon(Icons.note_outlined),
                        maxLines: 2,
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),
                      AppButton(
                        label: l10n.registerVisitorButton,
                        icon: Icons.person_add,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final code =
                                'SIGRA-${(Random().nextInt(9000) + 1000)}';
                            final newVisitor = Visitor(
                              id: 'vis-${DateTime.now().millisecondsSinceEpoch}',
                              residentId: 'usr-001',
                              residentApartment: '4-B',
                              visitorName: nameCtrl.text.trim(),
                              visitorCedula: cedulaCtrl.text.trim(),
                              expectedDate: selectedDate,
                              status: VisitorStatus.pending,
                              vehiclePlate: plateCtrl.text.trim().isEmpty
                                  ? null
                                  : plateCtrl.text.trim(),
                              notes: notesCtrl.text.trim().isEmpty
                                  ? null
                                  : notesCtrl.text.trim(),
                              accessCode: code,
                            );
                            setState(() => _visitors.add(newVisitor));
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(l10n.visitorRegisteredSuccess),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
