import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';
import 'package:creddinv_task/features/checkout/presentation/checkout_input_formatters.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:creddinv_task/shared/widgets/app_text_field.dart';

class CardPaymentForm extends StatefulWidget {
  const CardPaymentForm({
    required this.numberController,
    required this.expiryController,
    required this.cvvController,
    required this.onChanged,
    required this.showErrors,
    super.key,
  });

  final TextEditingController numberController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;
  final VoidCallback onChanged;
  final bool showErrors;

  @override
  State<CardPaymentForm> createState() => _CardPaymentFormState();
}

class _CardPaymentFormState extends State<CardPaymentForm> {
  late final FocusNode _numberFocus;
  late final FocusNode _expiryFocus;
  late final FocusNode _cvvFocus;
  final _touched = <String>{};

  @override
  void initState() {
    super.initState();
    _numberFocus = FocusNode()
      ..addListener(() => _mark('number', _numberFocus));
    _expiryFocus = FocusNode()
      ..addListener(() => _mark('expiry', _expiryFocus));
    _cvvFocus = FocusNode()..addListener(() => _mark('cvv', _cvvFocus));
  }

  @override
  void dispose() {
    _numberFocus.dispose();
    _expiryFocus.dispose();
    _cvvFocus.dispose();
    super.dispose();
  }

  void _mark(String field, FocusNode node) {
    if (node.hasFocus || _touched.contains(field)) return;
    setState(() => _touched.add(field));
  }

  String? _error(String field, String? message) {
    if (!widget.showErrors && !_touched.contains(field)) return null;
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      child: Column(
        children: [
          AppTextField(
            controller: widget.numberController,
            focusNode: _numberFocus,
            label: 'Card number',
            hintText: '4242 4242 4242 4242',
            helperText: 'Demo card. Checked on this device only.',
            errorText: _error(
              'number',
              CheckoutValidator.cardNumber(widget.numberController.text),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: CheckoutInputFormatters.cardNumber,
            onChanged: (_) => widget.onChanged(),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  controller: widget.expiryController,
                  focusNode: _expiryFocus,
                  label: 'Expiry',
                  hintText: '12/30',
                  helperText: 'MM/YY',
                  errorText: _error(
                    'expiry',
                    CheckoutValidator.expiry(widget.expiryController.text),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: CheckoutInputFormatters.expiry,
                  onChanged: (_) => widget.onChanged(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppTextField(
                  controller: widget.cvvController,
                  focusNode: _cvvFocus,
                  label: 'CVV',
                  hintText: '123',
                  helperText: '3 or 4 digits',
                  errorText: _error(
                    'cvv',
                    CheckoutValidator.cvv(widget.cvvController.text),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  inputFormatters: CheckoutInputFormatters.cvv,
                  onChanged: (_) => widget.onChanged(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
