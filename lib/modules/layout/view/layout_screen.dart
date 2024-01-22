import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/basket/view/screen/basket_screen.dart';
import 'package:atlobha/modules/home/view/screen/home_screen.dart';
import 'package:atlobha/modules/my_orders/view/screen/my_orders_screen.dart';
import 'package:atlobha/modules/setting/view/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutScreen extends StatefulWidget {
  final int? index;

  const LayoutScreen({Key? key, this.index}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.index ?? 0;
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyOrdersScreen(),

    BasketScreen(),

    SettingScreen(),

    // SettingScreen(),
    // HomeScreen(),
    // BasketScreen(),
    // MyOrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: MyNavigationBar(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class MyNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const MyNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: ColorManager.yellow2,
      // Change to your golden color
      unselectedItemColor: ColorManager.black,
      onTap: onItemTapped,
      items: [
        _buildNavigationBarItem(Icons.home_outlined, 'Home'.tr, 0),
        _buildNavigationBarItem(
            Icons.assignment_return_outlined, 'My Orders'.tr, 1),
        _buildNavigationBarItem(Icons.shopping_basket_outlined, 'Basket'.tr, 2),
        _buildNavigationBarItem(Icons.settings_outlined, 'Settings'.tr, 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected
                ? ColorManager.yellow2
                : ColorManager.firstBlack.withOpacity(0.9),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: isSelected ? ColorManager.yellow2 : ColorManager.black,
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}
