import 'package:prototype/domain/entities/payment.dart';

abstract class PaymentRepository {
  Future<List<Payment>> getPayments(String userId);
  Future<Payment?> getPaymentById(String id);
  Future<bool> submitPayment(Payment payment);
}
