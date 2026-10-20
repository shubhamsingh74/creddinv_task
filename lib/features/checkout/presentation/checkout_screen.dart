import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:creddinv_task/core/router/app_routes.dart';
import 'package:creddinv_task/core/theme/app_colors.dart';
import 'package:creddinv_task/core/theme/app_text_styles.dart';
import 'package:creddinv_task/core/utils/price_formatter.dart';
import 'package:creddinv_task/features/auth/bloc/auth_bloc.dart';
import 'package:creddinv_task/features/cart/bloc/cart_bloc.dart';
import 'package:creddinv_task/features/checkout/bloc/checkout_bloc.dart';
import 'package:creddinv_task/features/checkout/data/payment_method.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_action_bar.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_confirmation.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_step_body.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/checkout_step_header.dart';
import 'package:creddinv_task/features/checkout/presentation/widgets/empty_checkout_view.dart';
import 'package:creddinv_task/shared/widgets/app_scaffold.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _card = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  final _upi = TextEditingController();
  bool _showFieldErrors = false;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthAuthenticated) {
      _name.text = auth.user.displayName;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _publish();
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _card.dispose();
    _expiry.dispose();
    _cvv.dispose();
    _upi.dispose();
    super.dispose();
  }

  void _publish() {
    final current = context.read<CheckoutBloc>().state.draft;
    context.read<CheckoutBloc>().add(
      CheckoutDraftChanged(
        current.copyWith(
          name: _name.text,
          phone: _phone.text,
          address: _address.text,
          cardNumber: _card.text,
          expiry: _expiry.text,
          cvv: _cvv.text,
          upiId: _upi.text,
        ),
      ),
    );
  }

  void _selectMethod(PaymentMethod method) {
    final current = context.read<CheckoutBloc>().state.draft;
    context.read<CheckoutBloc>().add(
      CheckoutDraftChanged(current.copyWith(method: method)),
    );
  }

  void _onContinue(CheckoutState checkout, CartState cart) {
    if (checkout.submitting) return;
    if (!checkout.canContinue) {
      setState(() => _showFieldErrors = true);
      return;
    }
    if (_showFieldErrors) {
      setState(() => _showFieldErrors = false);
    }
    if (checkout.step == CheckoutStep.review) {
      context.read<CheckoutBloc>().add(CheckoutSubmitted(cart.items));
      return;
    }
    context.read<CheckoutBloc>().add(const CheckoutStepAdvanced());
  }

  void _back(CheckoutStep step) {
    if (step == CheckoutStep.details) {
      context.pop();
      return;
    }
    context.read<CheckoutBloc>().add(const CheckoutStepReverted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutBloc, CheckoutState>(
      listenWhen: (previous, current) =>
          previous.order == null && current.order != null,
      listener: (context, state) {
        context.read<CartBloc>().add(const CartCleared());
      },
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, checkout) {
          final order = checkout.order;
          if (order != null) {
            return AppScaffold(body: CheckoutConfirmation(order: order));
          }

          return BlocBuilder<CartBloc, CartState>(
            builder: (context, cart) {
              return AppScaffold(
                appBar: AppBar(
                  title: const Text('Checkout'),
                  leading: BackButton(onPressed: () => _back(checkout.step)),
                ),
                body: cart.isEmpty
                    ? EmptyCheckoutView(
                        onBack: () => context.go(AppRoutes.products),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.fromLTRB(
                                20.w,
                                8.h,
                                20.w,
                                20.h,
                              ),
                              children: [
                                CheckoutStepHeader(step: checkout.step),
                                SizedBox(height: 20.h),
                                CheckoutStepBody(
                                  checkout: checkout,
                                  cart: cart,
                                  name: _name,
                                  phone: _phone,
                                  address: _address,
                                  card: _card,
                                  expiry: _expiry,
                                  cvv: _cvv,
                                  upi: _upi,
                                  onChanged: _publish,
                                  onMethod: _selectMethod,
                                  showErrors: _showFieldErrors,
                                ),
                                if (checkout.error != null) ...[
                                  SizedBox(height: 16.h),
                                  Text(
                                    checkout.error!,
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.danger,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          CheckoutActionBar(
                            checkout: checkout,
                            totalLabel: PriceFormatter.formatCents(
                              cart.totalInCents,
                            ),
                            onPressed: () => _onContinue(checkout, cart),
                          ),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
