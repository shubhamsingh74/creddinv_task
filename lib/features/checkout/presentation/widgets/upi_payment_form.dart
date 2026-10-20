import 'package:flutter/material.dart';

import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';
import 'package:creddinv_task/features/checkout/presentation/checkout_input_formatters.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:creddinv_task/shared/widgets/app_text_field.dart';

class UpiPaymentForm extends StatefulWidget {
  const UpiPaymentForm({
    required this.controller,
    required this.onChanged,
    required this.showErrors,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onChanged;
  final bool showErrors;

  @override
  State<UpiPaymentForm> createState() => _UpiPaymentFormState();
}

class _UpiPaymentFormState extends State<UpiPaymentForm> {
  late final FocusNode _focus;
  var _touched = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode()
      ..addListener(() {
        if (_focus.hasFocus || _touched) return;
        setState(() => _touched = true);
      });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final show = widget.showErrors || _touched;
    return CheckoutSectionCard(
      child: AppTextField(
        controller: widget.controller,
        focusNode: _focus,
        label: 'UPI id',
        hintText: 'name@bank',
        helperText: 'Checked on this device. No payment app is opened.',
        errorText: show ? CheckoutValidator.upi(widget.controller.text) : null,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        inputFormatters: CheckoutInputFormatters.upi,
        onChanged: (_) => widget.onChanged(),
      ),
    );
  }
}
