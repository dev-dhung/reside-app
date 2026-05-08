import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/services/export_service.dart';
import 'package:prototype/data/datasources/mock/mock_session_logs.dart';
import 'package:prototype/data/repositories/metrics_repository_impl.dart';
import 'package:prototype/domain/entities/metric.dart';
import 'package:prototype/domain/entities/session_log.dart';
import 'package:prototype/domain/repositories/metrics_repository.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  final MetricsRepository _repo = MockMetricsRepository();

  List<MetricCard> _kpis = const [];
  List<PaymentMetric> _monthly = const [];
  List<ExpenseBreakdown> _expenses = const [];
  List<ChatLog> _chatLogs = const [];
  final List<SessionLog> _sessions = mockSessionLogs;

  bool _loading = true;
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final results = await Future.wait([
      _repo.getAdminMetrics(),
      _repo.getMonthlyPayments(),
      _repo.getExpenseBreakdown(),
      _repo.getRecentChatLogs(),
    ]);

    if (!mounted) return;
    setState(() {
      _kpis = results[0] as List<MetricCard>;
      _monthly = results[1] as List<PaymentMetric>;
      _expenses = results[2] as List<ExpenseBreakdown>;
      _chatLogs = results[3] as List<ChatLog>;
      _loading = false;
    });
  }

  int get _sessionsToday {
    final today = DateTime.now();
    return _sessions
        .where((s) =>
            s.date.year == today.year &&
            s.date.month == today.month &&
            s.date.day == today.day)
        .length;
  }

  Future<void> _exportPdf() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final cols = <ExportColumn<SessionLog>>[
        ExportColumn(header: 'Propietario', field: (r) => r.ownerName),
        ExportColumn(header: 'Apartamento', field: (r) => r.apartment),
        ExportColumn(header: 'Tipo', field: (r) => r.typeLabel),
        ExportColumn(header: 'Fecha', field: (r) => _fmtDate(r.date)),
        ExportColumn(header: 'Hora', field: (r) => r.time),
        ExportColumn(header: 'Dispositivo', field: (r) => r.device),
        ExportColumn(header: 'IP', field: (r) => r.ip),
      ];
      await ExportService.instance.exportToPdf<SessionLog>(
        filename: 'sigra-metricas',
        title: 'Métricas y actividad de propietarios',
        columns: cols,
        rows: _sessions,
      );
    } catch (e) {
      _showSnack('No se pudo generar el PDF: $e');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<void> _exportXlsx() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final cols = <ExportColumn<SessionLog>>[
        ExportColumn(header: 'Propietario', field: (r) => r.ownerName),
        ExportColumn(header: 'Apartamento', field: (r) => r.apartment),
        ExportColumn(header: 'Tipo', field: (r) => r.typeLabel),
        ExportColumn(header: 'Fecha', field: (r) => _fmtDate(r.date)),
        ExportColumn(header: 'Hora', field: (r) => r.time),
        ExportColumn(header: 'Dispositivo', field: (r) => r.device),
        ExportColumn(header: 'IP', field: (r) => r.ip),
      ];
      await ExportService.instance.exportToXlsx<SessionLog>(
        filename: 'sigra-metricas',
        sheetName: 'Sesiones',
        columns: cols,
        rows: _sessions,
      );
    } catch (e) {
      _showSnack('No se pudo generar el Excel: $e');
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  String _fmtDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          WaveHeader(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Métricas y Estadísticas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Actividad de propietarios',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _HeaderIconButton(
                    icon: Icons.picture_as_pdf_rounded,
                    onTap: _exporting ? null : _exportPdf,
                  ),
                  const SizedBox(width: 8),
                  _HeaderIconButton(
                    icon: Icons.table_view_rounded,
                    onTap: _exporting ? null : _exportXlsx,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _load,
                    color: AppColors.primary,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppDimensions.paddingLarge,
                        AppDimensions.paddingMedium,
                        AppDimensions.paddingLarge,
                        AppDimensions.paddingXL,
                      ),
                      children: [
                        _buildKpiGrid(),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        _SectionTitle(
                          title: 'Recaudación mensual',
                          subtitle: 'Cobrado vs pendiente (Bs.)',
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        _CardContainer(child: _buildPaymentsChart()),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        _SectionTitle(
                          title: 'Distribución de gastos',
                          subtitle: 'Asignación mensual del condominio',
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        _CardContainer(child: _buildExpensesDonut()),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        _SectionTitle(
                          title: 'Sesiones de propietarios',
                          subtitle:
                              '$_sessionsToday hoy · ${_sessions.length} totales',
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        _CardContainer(child: _buildSessionsTable()),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        _SectionTitle(
                          title: 'Resoluciones del chatbot',
                          subtitle: 'Últimas interacciones',
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        _CardContainer(child: _buildChatLogs()),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // KPI grid
  // ---------------------------------------------------------------------------

  Widget _buildKpiGrid() {
    final kpis = <_Kpi>[
      _Kpi(
        label: 'Sesiones hoy',
        value: '$_sessionsToday',
        subtitle: 'Inicios y cierres',
        icon: Icons.login_rounded,
        color: AppColors.primary,
      ),
      ..._kpis.map((m) => _Kpi(
            label: m.title,
            value: m.value,
            subtitle: m.subtitle,
            icon: _iconFor(m.title),
            color: _colorForTrend(m.trend),
          )),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.55,
      children: kpis.map((k) => _KpiCard(kpi: k)).toList(),
    );
  }

  IconData _iconFor(String title) {
    final t = title.toLowerCase();
    if (t.contains('moros')) return Icons.money_off_rounded;
    if (t.contains('fondo') || t.contains('reserva')) {
      return Icons.savings_rounded;
    }
    if (t.contains('chatbot') || t.contains('resolución')) {
      return Icons.smart_toy_rounded;
    }
    return Icons.bar_chart_rounded;
  }

  Color _colorForTrend(String trend) {
    switch (trend) {
      case 'up':
        return AppColors.success;
      case 'down':
        return AppColors.error;
      default:
        return AppColors.info;
    }
  }

  // ---------------------------------------------------------------------------
  // Payments chart
  // ---------------------------------------------------------------------------

  Widget _buildPaymentsChart() {
    if (_monthly.isEmpty) {
      return const SizedBox(height: 200);
    }
    final maxY = _monthly
            .map((m) => m.collected + m.pending)
            .fold<double>(0, (a, b) => a > b ? a : b) *
        1.1;

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: AppColors.divider,
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) => Text(
                  value >= 1000
                      ? '${(value / 1000).toStringAsFixed(1)}k'
                      : value.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  final i = value.toInt();
                  if (i < 0 || i >= _monthly.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      _monthly[i].month,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(_monthly.length, (i) {
            final m = _monthly[i];
            return BarChartGroupData(
              x: i,
              barsSpace: 4,
              barRods: [
                BarChartRodData(
                  toY: m.collected,
                  color: AppColors.primary,
                  width: 10,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                BarChartRodData(
                  toY: m.pending,
                  color: AppColors.accent,
                  width: 10,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Expenses donut
  // ---------------------------------------------------------------------------

  Widget _buildExpensesDonut() {
    if (_expenses.isEmpty) {
      return const SizedBox(height: 200);
    }

    final palette = <Color>[
      AppColors.primary,
      AppColors.accent,
      AppColors.info,
      AppColors.warning,
      AppColors.success,
    ];

    return SizedBox(
      height: 220,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 42,
                sections: List.generate(_expenses.length, (i) {
                  final e = _expenses[i];
                  return PieChartSectionData(
                    value: e.percentage,
                    title: '${e.percentage.toStringAsFixed(0)}%',
                    color: palette[i % palette.length],
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(_expenses.length, (i) {
                final e = _expenses[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: palette[i % palette.length],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          e.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$${e.amount.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Sessions
  // ---------------------------------------------------------------------------

  Widget _buildSessionsTable() {
    final visible = _sessions.take(8).toList();
    return Column(
      children: [
        for (final s in visible)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: (s.type == SessionType.login
                            ? AppColors.success
                            : AppColors.textTertiary)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    s.type == SessionType.login
                        ? Icons.login_rounded
                        : Icons.logout_rounded,
                    color: s.type == SessionType.login
                        ? AppColors.success
                        : AppColors.textTertiary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.ownerName,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${s.apartment} · ${s.device}',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      s.time,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _fmtDate(s.date),
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (_sessions.length > visible.length)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'Y ${_sessions.length - visible.length} registros más en el reporte exportado',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Chat logs
  // ---------------------------------------------------------------------------

  Widget _buildChatLogs() {
    if (_chatLogs.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Sin registros recientes.',
          style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
        ),
      );
    }
    return Column(
      children: _chatLogs.map((l) {
        final color = l.resolution.toLowerCase().contains('resuelta')
            ? AppColors.success
            : AppColors.warning;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.topic,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Apto ${l.apartment} · ${l.resolution}',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${l.date.day}/${l.date.month}',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// =============================================================================
// Internal widgets
// =============================================================================

class _Kpi {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _Kpi({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class _KpiCard extends StatelessWidget {
  final _Kpi kpi;
  const _KpiCard({required this.kpi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: kpi.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(kpi.icon, color: kpi.color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  kpi.label,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            kpi.value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            kpi.subtitle,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textTertiary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  const _CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: disabled ? 0.08 : 0.18),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.white.withValues(alpha: disabled ? 0.5 : 1),
          size: 20,
        ),
      ),
    );
  }
}
