import '../../../data/models/customers_model.dart';

abstract interface class CustomerServiceInterface {
  Future<UsersResponse> getAllCustomers(int nextPage);

  Future<UsersResponse> getCustomerByName(String name);
}
