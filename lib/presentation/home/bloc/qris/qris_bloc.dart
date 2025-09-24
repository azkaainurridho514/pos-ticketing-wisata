import 'package:bloc/bloc.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/midtrans_remote_datasource.dart';
import 'package:cbt_tpa_fic17_app/data/models/response/qris_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qris_event.dart';
part 'qris_state.dart';
part 'qris_bloc.freezed.dart';

class QrisBloc extends Bloc<QrisEvent, QrisState> {
  final MidtrasRemoteDatasource midtrasRemoteDatasource;
  QrisBloc(this.midtrasRemoteDatasource) : super(_Initial()) {
    on<_GenerateQRCode>((event, emit) async {
      emit(const _Loading());
      try {
        final response = await midtrasRemoteDatasource.generateQRCode(
            event.orderId, event.grossAmount);
        emit(QrisState.qrisResponse(response));
      } catch (e) {
        emit(QrisState.error(e.toString()));
      }
    });
  }
}
