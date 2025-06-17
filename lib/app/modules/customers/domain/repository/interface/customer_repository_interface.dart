import '../../../data/models/customers_model.dart';

abstract interface class CustomerRepositoryInterface {
  Future<UsersResponse> getAllCustomers(int nextPage);

  Future<UsersResponse> getCustomerByName(String name);
}
