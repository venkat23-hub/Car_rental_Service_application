import '../models/customer.dart';
import '../data/dummy_customers.dart';

class CustomerService {
  List<Customer> _customers = dummyCustomers; // Use the dummy data

  // Get all customers
  List<Customer> getAllCustomers() {
    return _customers;
  }

  // Get a customer by ID
  Customer? getCustomerById(String id) {
    try {
      return _customers.firstWhere((customer) => customer.id == id);
    } catch (e) {
      return null; // Return null if no customer is found
    }
  }

  // Add a new customer
  void addCustomer(Customer customer) {
    _customers.add(customer);
  }

  // Update an existing customer
  void updateCustomer(Customer updatedCustomer) {
    final index = _customers.indexWhere((customer) => customer.id == updatedCustomer.id);
    if (index != -1) {
      _customers[index] = updatedCustomer;
    }
  }

  // Delete a customer
  void deleteCustomer(String id) {
    _customers.removeWhere((customer) => customer.id == id);
  }
}
