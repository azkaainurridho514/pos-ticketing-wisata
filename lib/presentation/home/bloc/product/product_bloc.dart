import 'package:bloc/bloc.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/product_local_datasource.dart';
import 'package:cbt_tpa_fic17_app/data/datasources/product_remote_data_source.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/response/product_response_model.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  ProductBloc(
    this.productRemoteDataSource,
    this.productLocalDataSource,
  ) : super(_Initial()) {
    List<Product> products = [];
    on<_GetProduct>((event, emit) async {
      emit(_Loading());
      final result = await productRemoteDataSource.getProducts();
      result.fold((error) {
        emit(_Error(error));
      }, (data) {
        emit(_Success(data.data ?? []));
      });
    });
    on<_SyncProduct>((event, emit) async {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        emit(_Error('No Internet Connection'));
      } else {
        emit(_Loading());
        final response = await productRemoteDataSource.getProducts();
        productLocalDataSource.removeAllProduct();
        productLocalDataSource.insertAllProduct(
            response.getOrElse(() => ProductResponseModel(data: [])).data ??
                []);
        products =
            response.getOrElse(() => ProductResponseModel(data: [])).data ?? [];
        emit(_Success(products));
      }
    });
    on<_GetLocalProducts>((event, emit) async {
      emit(_Loading());
      final localProducts = await productLocalDataSource.getAllProducts();
      products = localProducts;
      emit(_Success(products));
    });
  }
}
