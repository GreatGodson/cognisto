import 'dart:convert';

import 'package:cognisto/app/modules/customers/data/models/customers_model.dart';
import 'package:cognisto/app/modules/customers/domain/service/interface/customer_service_interface.dart';
import 'package:cognisto/app/shared/network/endpoints.dart';
import 'package:cognisto/app/shared/network/exceptions.dart';
import 'package:cognisto/core/framework/HTTP/http.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CustomerServiceInterface)
class CustomerService implements CustomerServiceInterface {
  @override
  Future<UsersResponse> getAllCustomers(int nextPage) async {
    final response = await HTTP.get(
      "${EndPoints.users}?limit=10&skip=$nextPage",
    );
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      final map = UsersResponse.fromJson(Map.from(decode));
      return map;
    }
    throw AppException.fromResponse(response);
  }

  @override
  Future<UsersResponse> getCustomerByName(String query) async {
    final response = await HTTP.get("${EndPoints.users}/search?q=$query");
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      final map = UsersResponse.fromJson(Map.from(decode));
      return map;
    }
    throw AppException.fromResponse(response);
  }
}
