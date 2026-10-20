import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:creddinv_task/features/checkout/data/checkout_validator.dart';
import 'package:creddinv_task/features/checkout/presentation/checkout_input_formatters.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:creddinv_task/shared/widgets/app_text_field.dart';

class DeliveryDetailsForm extends StatefulWidget {
  const DeliveryDetailsForm({
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.onChanged,
    required this.showErrors,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final VoidCallback onChanged;
  final bool showErrors;

  @override
  State<DeliveryDetailsForm> createState() => _DeliveryDetailsFormState();
}

class _DeliveryDetailsFormState extends State<DeliveryDetailsForm> {
  late final FocusNode _nameFocus;
  late final FocusNode _phoneFocus;
  late final FocusNode _addressFocus;
  final _touched = <String>{};

  @override
  void initState() {
    super.initState();
    _nameFocus = FocusNode()..addListener(() => _mark('name', _nameFocus));
    _phoneFocus = FocusNode()..addListener(() => _mark('phone', _phoneFocus));
    _addressFocus = FocusNode()
      ..addListener(() => _mark('address', _addressFocus));
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: widget.nameController,
            focusNode: _nameFocus,
            label: 'Full name',
            hintText: 'Recipient name',
            helperText: 'Letters only, first and last name.',
            errorText: _error(
              'name',
              CheckoutValidator.name(widget.nameController.text),
            ),
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            inputFormatters: CheckoutInputFormatters.name,
            onChanged: (_) => widget.onChanged(),
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: widget.phoneController,
            focusNode: _phoneFocus,
            label: 'Phone',
            hintText: '9876543210',
            helperText: '10 digits, starting with 6, 7, 8, or 9.',
            errorText: _error(
              'phone',
              CheckoutValidator.phone(widget.phoneController.text),
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: CheckoutInputFormatters.phone,
            onChanged: (_) => widget.onChanged(),
          ),
          SizedBox(height: 16.h),
          AppTextField(
            controller: widget.addressController,
            focusNode: _addressFocus,
            label: 'Address',
            hintText: '12 Market Street, Bengaluru 560001',
            helperText: 'Street, city, and a 6-digit PIN code.',
            errorText: _error(
              'address',
              CheckoutValidator.address(widget.addressController.text),
            ),
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.newline,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 3,
            onChanged: (_) => widget.onChanged(),
          ),
        ],
      ),
    );
  }
}
