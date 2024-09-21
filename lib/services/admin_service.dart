import '../models/admin.dart';
import '../data/dummy_admins.dart';

class AdminService {
  List<Admin> _admins = dummyAdmins; // Use the dummy data

  // Get all admins
  List<Admin> getAllAdmins() {
    return _admins;
  }

  // Get an admin by ID
  Admin? getAdminById(String id) {
    try {
      return _admins.firstWhere((admin) => admin.id == id);
    } catch (e) {
      return null; // Return null if no admin is found
    }
  }

  // Add a new admin
  void addAdmin(Admin admin) {
    _admins.add(admin);
  }

  // Update an existing admin
  void updateAdmin(Admin updatedAdmin) {
    final index = _admins.indexWhere((admin) => admin.id == updatedAdmin.id);
    if (index != -1) {
      _admins[index] = updatedAdmin;
    }
  }

  // Delete an admin
  void deleteAdmin(String id) {
    _admins.removeWhere((admin) => admin.id == id);
  }
}
