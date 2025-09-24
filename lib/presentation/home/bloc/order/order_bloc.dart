import 'package:bloc/bloc.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/auth_local_datasource.dart';
import 'package:cbt_tpa_fic17_app/presentation/home/bloc/checkout/models/order_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(_Success([], 0, 0, 0, "", 0, "")) {
    on<_AddPaymentMethod>((event, emit) async {
      emit(const _Loading());
      final userData = await AuthLocalDataSource().getAuthData();
      emit(_Success(
        event.orders,
        event.orders.fold(
          0,
          (previousValue, element) => previousValue + element.quantity,
        ),
        event.orders.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.product.price! * element.quantity)),
        0,
        event.paymentMethod,
        userData!.user!.id!,
        userData.user!.name!,
      ));
    });
    on<_AddNominalPayment>((event, emit) async {
      var currentState = state as _Success;
      emit(const _Loading());
      emit(_Success(
        currentState.orders,
        currentState.totalQty,
        currentState.totalPrice,
        event.nominalPayment,
        currentState.paymentMethod,
        currentState.cashierId,
        currentState.cashierName,
      ));
    });
    on<_Started>((event, emit) async {
      emit(const _Loading());
      emit(_Success([], 0, 0, 0, "", 0, ""));
    });
  }
}
