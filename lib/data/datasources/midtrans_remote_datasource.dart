import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/response/qris_response_model.dart';
import '../models/response/qris_status_reponse_model.dart';

class MidtrasRemoteDatasource {
  String generateBasicAuthUser(String serverKey) {
    final base64Credentials = base64Encode(utf8.encode('$serverKey:'));
    final authHeader = 'Basic $base64Credentials';
    return authHeader;
  }

  Future<QrisResponseModel> generateQRCode(
      String orderID, int grossAmount) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': generateBasicAuthUser(Variables.serverKey),
    };
    final body = {
      'payment_type': 'gopay',
      'transaction_details': {
        'order_id': orderID,
        'gross_amount': grossAmount,
      }
    };

    final response = await http.post(
      Uri.parse('${Variables.qrisBaseURL}/v2/charge'), // error di sini
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return QrisResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to generate QR code');
    }
  }

  Future<QrisStatusResponseModel> checkPaymentStatus(
      String transactionId) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': generateBasicAuthUser(Variables.serverKey),
    };
    final response = await http.get(
      Uri.parse('${Variables.qrisBaseURL}/v2/$transactionId/status'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return QrisStatusResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to check payment status');
    }
  }
}
