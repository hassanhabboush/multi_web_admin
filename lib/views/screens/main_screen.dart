import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/order_screen.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/product_screen.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/vendor_screen.dart';
import 'package:multi_web_admin/views/screens/side_bar_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSlector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case VendorScreen.routeName:
        setState(() {
          _selectedItem = VendorScreen();
        });
        break;

      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });
        break;

      case OrderScreen.routeName:
        setState(() {
          _selectedItem = OrderScreen();
        });
        break;

      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;

      case ProductScreen.routeName:
        setState(() {
          _selectedItem = ProductScreen();
        });
        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.yellow.shade900,
      //   title: Text('Management'),
      // ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Vendors',
            icon: CupertinoIcons.person_3,
            route: VendorScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            icon: CupertinoIcons.money_dollar,
            route: WithdrawalScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Orders',
            icon: CupertinoIcons.shopping_cart,
            route: OrderScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: CategoriesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: Icons.shop,
            route: ProductScreen.routeName,
          ),
          AdminMenuItem(
            title: ' Upload Banner',
            icon: CupertinoIcons.add,
            route: UploadBannerScreen.routeName,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSlector(item);
        },

        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Hassan Store Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedItem,
    );
  }
}
