import 'dart:async';

import 'package:cbt_tpa_fic17_app/presentation/home/bloc/qris/qris_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../core/core.dart';
import '../../../data/datasources/product_local_datasource.dart';
import '../bloc/checkout/models/order_item.dart';
import '../bloc/checkout/models/order_model.dart';
import '../bloc/order/order_bloc.dart';
import '../bloc/qris_status/qris_status_bloc.dart';
import '../pages/payment_success_page.dart';

class PaymentQrisDialog extends StatefulWidget {
  final int price;
  const PaymentQrisDialog({super.key, required this.price});
  @override
  State<PaymentQrisDialog> createState() => _PaymentQrisDialogState();
}

class _PaymentQrisDialogState extends State<PaymentQrisDialog> {
  String orderId = '';
  Timer? timer;
  @override
  void initState() {
    orderId = DateTime.now().millisecondsSinceEpoch.toString();
    context
        .read<QrisBloc>()
        .add(QrisEvent.generateQRCode(orderId, widget.price));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Show this QR code to customer'),
          const SpaceHeight(24.0),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 200.0,
              width: 200.0,
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  final (
                    orders,
                    totalQty,
                    totalPrice,
                    paymentNominal,
                    paymentMethod,
                    cashierId,
                    cashierName
                  ) = state.maybeWhen(
                    success: (orders, totalQty, totalPrice, paymentNominal,
                            paymentMethod, cashierId, cashierName) =>
                        (
                      orders,
                      totalQty,
                      totalPrice,
                      paymentNominal,
                      paymentMethod,
                      cashierId,
                      cashierName
                    ),
                    orElse: () => ([], 0, 0, 0, '', 0, ''),
                  );
                  return MultiBlocListener(
                    listeners: [
                      BlocListener<QrisBloc, QrisState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            qrisResponse: (qris) {
                              const onSec = Duration(seconds: 2);
                              timer = Timer.periodic(
                                onSec,
                                (timer) {
                                  context.read<QrisStatusBloc>().add(
                                      QrisStatusEvent.checkPaymentStatus(
                                          qris.transactionId));
                                },
                              );
                            },
                            orElse: () => timer?.cancel(),
                          );
                        },
                      ),
                      BlocListener<QrisStatusBloc, QrisStatusState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            success: (data) {
                              timer?.cancel();
                              final order = OrderModel(
                                  paymentMethod: paymentMethod,
                                  nominalPayment: paymentNominal,
                                  orders: orders as List<OrderItem>,
                                  totalQuantity: totalQty,
                                  totalPrice: totalPrice,
                                  cashierId: cashierId,
                                  cashierName: cashierName,
                                  isSync: false,
                                  transactionTime:
                                      DateTime.now().toIso8601String());
                              ProductLocalDataSource.instance
                                  .insertOrder(order);
                              context.pushReplacement(PaymentSuccessPage(
                                data: order,
                              ));
                            },
                            orElse: () {},
                          );
                        },
                      ),
                    ],
                    child: BlocBuilder<QrisBloc, QrisState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          qrisResponse: (qris) =>
                              Image.network(qris.actions.first.url),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          orElse: () => const Center(child: Text("No QR Code")),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          const SpaceHeight(24.0),
          Countdown(
            seconds: 60,
            build: (context, time) => Text.rich(
              TextSpan(
                text: 'Update after ',
                children: [
                  TextSpan(
                    text: '${time.toInt()}s.',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            onFinished: () {},
          ),
        ],
      ),
    );
  }
}
