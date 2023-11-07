import 'package:flats/app_router.dart';
import 'package:flats/widgets/flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddPaymentScreen extends StatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  final TextEditingController _paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset('assets/arrow_back.svg'),
                  ),
                  const Text(
                    'LOAN INFO',
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
            SliverFillRemaining(
              child: Center(
                child: TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: _paymentController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  onChanged: (value) {
                    if (!value.contains('\$')) {
                      final newValue = '$value\$';
                      _paymentController.value = TextEditingValue(
                        text: newValue,
                        selection: TextSelection.collapsed(
                          offset: newValue.length - 1,
                        ),
                      );
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FlatButton(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 50,
        onTap: () {
          if (_paymentController.text.isEmpty) return;
          final int? amount = int.tryParse(_paymentController.text
              .substring(0, _paymentController.text.length - 1));
          if (amount == null) return;

          context.pop(amount);
        },
        text: 'ADD PAYMENT',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
