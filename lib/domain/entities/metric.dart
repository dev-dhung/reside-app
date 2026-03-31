class MetricCard {
  final String title;
  final String value;
  final String subtitle;
  final String trend;

  const MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.trend,
  });
}

class ChatbotMetric {
  final String topic;
  final double percentage;

  const ChatbotMetric({
    required this.topic,
    required this.percentage,
  });
}

class ChatLog {
  final String apartment;
  final String topic;
  final String resolution;
  final DateTime date;

  const ChatLog({
    required this.apartment,
    required this.topic,
    required this.resolution,
    required this.date,
  });
}

class PaymentMetric {
  final String month;
  final double collected;
  final double pending;

  const PaymentMetric({
    required this.month,
    required this.collected,
    required this.pending,
  });
}

class ExpenseBreakdown {
  final String category;
  final double amount;
  final double percentage;

  const ExpenseBreakdown({
    required this.category,
    required this.amount,
    required this.percentage,
  });
}
