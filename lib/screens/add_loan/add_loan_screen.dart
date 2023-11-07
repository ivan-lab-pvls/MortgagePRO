import 'package:flats/app_router.dart';
import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flats/screens/add_loan/widgets/payment_type_picker.dart';
import 'package:flats/widgets/app_text_field.dart';
import 'package:flats/widgets/flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddLoanScreen extends StatefulWidget {
  const AddLoanScreen({super.key});

  @override
  State<AddLoanScreen> createState() => _AddLoanScreenState();
}

class _AddLoanScreenState extends State<AddLoanScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _firstPaymentDateController =
      TextEditingController();

  PaymentType _paymentType = PaymentType.annuity;
  DateTime? firstPaymentDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset('assets/arrow_back.svg'),
                    ),
                    const Text(
                      'ADD LOAN',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.push(AppRouter.settigs),
                      child: SvgPicture.asset('assets/gear.svg'),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        title: 'Title',
                        controller: _titleController,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              keyboardType: TextInputType.number,
                              title: 'Amount',
                              controller: _amountController,
                              formatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              onChanged: (value) {
                                if (!value.contains('\$')) {
                                  final newValue = '$value\$';
                                  _amountController.value = TextEditingValue(
                                    text: newValue,
                                    selection: TextSelection.collapsed(
                                      offset: newValue.length - 1,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppTextField(
                              keyboardType: TextInputType.number,
                              title: 'Rate',
                              formatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              controller: _rateController,
                              onChanged: (value) {
                                if (value.length > 2) {
                                  value = value.substring(0, 2);
                                }
                                if (!value.contains('%')) {
                                  final newValue = '$value%';
                                  _rateController.value = TextEditingValue(
                                    text: newValue,
                                    selection: TextSelection.collapsed(
                                      offset: newValue.length - 1,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              keyboardType: TextInputType.number,
                              title: 'Term',
                              formatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              controller: _termController,
                              onChanged: (value) {
                                if (!value.contains('months')) {
                                  final newValue = '$value months';
                                  _termController.value = TextEditingValue(
                                    text: newValue,
                                    selection: TextSelection.collapsed(
                                      offset: newValue.length - 7,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                final result = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .copyWith(year: DateTime.now().year - 30),
                                  lastDate: DateTime.now()
                                      .copyWith(year: DateTime.now().year + 30),
                                );
                                if (result == null) return;
                                firstPaymentDate = result;
                                _firstPaymentDateController.text =
                                    DateFormat('dd.MM.yyyy').format(result);
                              },
                              child: AppTextField(
                                enabled: false,
                                title: 'First payment date',
                                controller: _firstPaymentDateController,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 32,
                        color: Color(0xFF202029),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Payment type',
                          style: TextStyle(
                            color: AppTheme.lightColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PaymentTypePicker(
                        paymentType: _paymentType,
                        onTap: (value) {
                          setState(() {
                            _paymentType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FlatButton(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.5,
          onTap: () => _onAddLoanTap(context),
          text: 'ADD LOAN',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  void _onAddLoanTap(BuildContext context) {
    if (firstPaymentDate == null ||
        _amountController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _termController.text.isEmpty ||
        _titleController.text.isEmpty) {
      return;
    }

    final int amount = int.tryParse(_amountController.text
            .substring(0, _amountController.text.length - 1)) ??
        0;
    final int rate = int.tryParse(_rateController.text
            .substring(0, _rateController.text.length - 1)) ??
        0;
    final int term = int.tryParse(_termController.text
            .substring(0, _termController.text.length - 7)) ??
        0;

    final loan = Loan(
      title: _titleController.text,
      amount: amount,
      rate: rate,
      term: term,
      firstPaymentDate: firstPaymentDate!,
      paymentType: _paymentType,
      payments: [],
    );

    context.pop(loan);
  }
}
