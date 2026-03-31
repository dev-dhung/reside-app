import 'package:prototype/domain/entities/metric.dart';
import 'package:prototype/domain/repositories/metrics_repository.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';

class MockMetricsRepository implements MetricsRepository {
  @override
  Future<List<MetricCard>> getAdminMetrics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockAdminMetrics;
  }

  @override
  Future<List<MetricCard>> getResidentMetrics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockResidentMetrics;
  }

  @override
  Future<List<ChatbotMetric>> getChatbotTopics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockChatbotTopics;
  }

  @override
  Future<List<ChatLog>> getRecentChatLogs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockChatLogs;
  }

  @override
  Future<List<PaymentMetric>> getMonthlyPayments() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockMonthlyPayments;
  }

  @override
  Future<List<ExpenseBreakdown>> getExpenseBreakdown() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockExpenseBreakdown;
  }
}
