import 'package:cbt_tpa_fic17_app/core/core.dart';
import 'package:cbt_tpa_fic17_app/presentation/home/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checkout/checkout_bloc.dart';
import '../widgets/order_card.dart';
import 'order_detail_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductEvent.getLocalProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan Tiket'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          final products = state.maybeWhen(
              orElse: () => [], success: (products) => products);
          if (products.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada tiket',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SpaceHeight(20.0),
            itemBuilder: (context, index) => OrderCard(
              item: products[index],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Order Summary'),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const Text(
                          'Rp. 0',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        success: (checkout) {
                          final total = checkout.fold<int>(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  element.product.price! * element.quantity);

                          return Text(
                            total.currencyFormatRp,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Button.filled(
                height: 48,
                width: 120,
                onPressed: () {
                  context.push(const OrderDetailPage());
                },
                label: 'Process',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
