import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../../core/core.dart';
import '../bloc/checkout/models/order_model.dart';

class HistoryCard extends StatelessWidget {
  final OrderModel item;
  const HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.stroke),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Assets.icons.plus.svg(),
          const SpaceWidth(10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.cashierName.toString(),
                style: const TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(5.0),
              Text(
                DateFormat('HH:mm, MMM d yyyy')
                    .format(DateTime.parse(item.transactionTime)),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            item.totalPrice.currencyFormatRp,
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
