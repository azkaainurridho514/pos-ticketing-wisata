import 'package:cbt_tpa_fic17_app/data/models/response/product_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class ProductRemoteDataSource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDataSource().getAuthData();

    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api-products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData!.token}',
      },
    );

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
