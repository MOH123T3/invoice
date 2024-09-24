import 'package:autorepair/imports.dart';

class ProviderController extends ChangeNotifier {
  List<EmployeeModel> employees = [];

  addEmployee(EmployeeModel employee) {
    employees.add(employee);
    notifyListeners();
  }
}
