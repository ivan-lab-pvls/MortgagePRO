// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loan _$LoanFromJson(Map<String, dynamic> json) => Loan(
      title: json['title'] as String,
      amount: json['amount'] as int,
      rate: json['rate'] as int,
      term: json['term'] as int,
      firstPaymentDate: DateTime.parse(json['firstPaymentDate'] as String),
      paymentType: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      payments:
          (json['payments'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
      'title': instance.title,
      'amount': instance.amount,
      'rate': instance.rate,
      'term': instance.term,
      'firstPaymentDate': instance.firstPaymentDate.toIso8601String(),
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType]!,
      'payments': instance.payments,
    };

const _$PaymentTypeEnumMap = {
  PaymentType.annuity: 'annuity',
  PaymentType.differential: 'differential',
};
