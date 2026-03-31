import 'package:prototype/domain/entities/payment.dart';
import 'package:prototype/domain/repositories/payment_repository.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';

class MockPaymentRepository implements PaymentRepository {
  final List<Payment> _payments = List.from(mockPayments);

  @override
  Future<List<Payment>> getPayments(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _payments.where((p) => p.userId == userId).toList();
  }

  @override
  Future<Payment?> getPaymentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _payments.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> submitPayment(Payment payment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _payments.add(payment);
    return true;
  }
}
