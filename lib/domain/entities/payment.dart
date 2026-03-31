enum PaymentMethod { transfer, mobilePay, zelle, cash }

enum PaymentStatus { pending, approved, rejected }

class Payment {
  final String id;
  final String userId;
  final double amount;
  final String reference;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime date;
  final String? receiptUrl;
  final String? description;

  const Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.reference,
    required this.method,
    required this.status,
    required this.date,
    this.receiptUrl,
    this.description,
  });
}
