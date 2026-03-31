import '../entities/metric.dart';

abstract class MetricsRepository {
  Future<List<MetricCard>> getAdminMetrics();
  Future<List<MetricCard>> getResidentMetrics(String userId);
  Future<List<ChatbotMetric>> getChatbotTopics();
  Future<List<ChatLog>> getRecentChatLogs();
  Future<List<PaymentMetric>> getMonthlyPayments();
  Future<List<ExpenseBreakdown>> getExpenseBreakdown();
}
