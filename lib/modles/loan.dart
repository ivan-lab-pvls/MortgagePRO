// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'loan.g.dart';

@JsonSerializable()
class Loan {
  const Loan({
    required this.title,
    required this.amount,
    required this.rate,
    required this.term,
    required this.firstPaymentDate,
    required this.paymentType,
    required this.payments,
  });

  final String title;
  final int amount;
  final int rate;
  final int term;
  final DateTime firstPaymentDate;
  final PaymentType paymentType;
  final List<int> payments;

  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

  Map<String, dynamic> toJson() => _$LoanToJson(this);

  Loan copyWith({
    String? title,
    int? amount,
    int? rate,
    int? term,
    DateTime? firstPaymentDate,
    PaymentType? paymentType,
    List<int>? payments,
  }) {
    return Loan(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      rate: rate ?? this.rate,
      term: term ?? this.term,
      firstPaymentDate: firstPaymentDate ?? this.firstPaymentDate,
      paymentType: paymentType ?? this.paymentType,
      payments: payments ?? this.payments,
    );
  }
}

enum PaymentType {
  annuity,
  differential,
}
