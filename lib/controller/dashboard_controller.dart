import 'package:autorepair/imports.dart';

class DashboardController {
  final dashboardList = [
    DashboardModel(
      icon: Icons.list_alt_outlined,
      title: 'Total\nProduct',
      value: '0',
    ),
    DashboardModel(
      icon: Icons.groups_outlined,
      title: 'Total\nCustomer',
      value: '0',
    ),
    DashboardModel(
      icon: Icons.payments_outlined,
      title: 'Weekly\nRevenue',
      value: '₹ 0',
    ),
    DashboardModel(
      icon: Icons.monetization_on,
      title: 'Total\nRevenue',
      value: '₹ 0',
    ),
    DashboardModel(
      icon: Icons.money,
      title: 'Total\nPaid',
      value: '₹ 0',
    ),
    DashboardModel(
      icon: Icons.money,
      title: 'Total\nDue',
      value: '₹ 0',
    ),
  ];
}
