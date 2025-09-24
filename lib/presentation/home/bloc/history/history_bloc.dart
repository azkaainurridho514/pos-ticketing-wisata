import 'package:bloc/bloc.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/product_local_datasource.dart';
import 'package:cbt_tpa_fic17_app/presentation/home/bloc/checkout/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  ProductLocalDataSource productLocalDataSource;
  HistoryBloc(
    this.productLocalDataSource,
  ) : super(_Initial()) {
    on<HistoryEvent>((event, emit) async {
      emit(_Loading());
      final histories = await productLocalDataSource.getAllOrder();
      emit(_Success(histories));
    });
  }
}
