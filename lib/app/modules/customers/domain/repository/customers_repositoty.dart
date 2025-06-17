import 'package:cognisto/app/modules/customers/data/models/customers_model.dart';
import 'package:cognisto/app/modules/customers/domain/repository/interface/customer_repository_interface.dart';
import 'package:cognisto/app/modules/customers/domain/service/interface/customer_service_interface.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CustomerRepositoryInterface)
class CustomerRepository implements CustomerRepositoryInterface {
  final CustomerServiceInterface customerServiceInterface;

  CustomerRepository({required this.customerServiceInterface});

  @override
  Future<UsersResponse> getAllCustomers(int nextPage) {
    return customerServiceInterface.getAllCustomers(nextPage);
  }

  @override
  Future<UsersResponse> getCustomerByName(String name) {
    return customerServiceInterface.getCustomerByName(name);
  }
}
