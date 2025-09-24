import 'package:bloc/bloc.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/midtrans_remote_datasource.dart';
import 'package:cbt_tpa_fic17_app/data/models/response/qris_status_reponse_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qris_status_event.dart';
part 'qris_status_state.dart';
part 'qris_status_bloc.freezed.dart';

class QrisStatusBloc extends Bloc<QrisStatusEvent, QrisStatusState> {
  final MidtrasRemoteDatasource remoteDataSource;
  QrisStatusBloc(this.remoteDataSource) : super(_Initial()) {
    on<_CheckPaymentStatus>((event, emit) async {
      emit(const _Loading());
      try {
        final response =
            await remoteDataSource.checkPaymentStatus(event.orderId);
        if (response.transactionStatus == 'settlement') {
          emit(const QrisStatusState.success('Payment Success'));
        } else if (response.transactionStatus == 'pending') {
          emit(const QrisStatusState.pending('Payment Pending'));
        }
        // else {
        //   emit(const QrisStatusState.error('Payment Failed'));
        // }
      } catch (e) {
        emit(QrisStatusState.error(e.toString()));
      }
    });
  }
}
