import 'package:prototype/domain/entities/payment.dart';

class PaymentModel {
  final String id;
  final String userId;
  final double amount;
  final String reference;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime date;
  final String? receiptUrl;
  final String? description;

  const PaymentModel({
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

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      reference: json['reference'] as String,
      method: PaymentMethod.values.firstWhere(
        (e) => e.name == json['method'],
      ),
      status: PaymentStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      date: DateTime.parse(json['date'] as String),
      receiptUrl: json['receiptUrl'] as String?,
      description: json['description'] as String?,
    );
  }

  factory PaymentModel.fromEntity(Payment payment) {
    return PaymentModel(
      id: payment.id,
      userId: payment.userId,
      amount: payment.amount,
      reference: payment.reference,
      method: payment.method,
      status: payment.status,
      date: payment.date,
      receiptUrl: payment.receiptUrl,
      description: payment.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'reference': reference,
      'method': method.name,
      'status': status.name,
      'date': date.toIso8601String(),
      'receiptUrl': receiptUrl,
      'description': description,
    };
  }

  Payment toEntity() {
    return Payment(
      id: id,
      userId: userId,
      amount: amount,
      reference: reference,
      method: method,
      status: status,
      date: date,
      receiptUrl: receiptUrl,
      description: description,
    );
  }
}
