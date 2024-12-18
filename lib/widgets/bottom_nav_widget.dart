import 'package:flutter/material.dart';
import 'package:leenas_mushrooms/dashboard/call_details_page.dart';
import 'package:leenas_mushrooms/dashboard/expense_page.dart';
import 'package:leenas_mushrooms/dashboard/home_page.dart';
import 'package:leenas_mushrooms/dashboard/order_details_page.dart';
import 'package:leenas_mushrooms/widgets/drawer_widget.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 28,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, Icons.home, "Daily Data"),
          _buildNavItem(1, Icons.person_add, "Call Details"),
          _buildNavItem(2, Icons.receipt_long, "Order Details"),
          _buildNavItem(3, Icons.payment, "INC/EXP"),
        ],
      ),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const CallDetailsPage(),
    const OrderDetailsPage(),
    const ExpensePage(),
  ];

  void _onItemTapped(int index) {
    if (index < pages.length) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(_selectedIndex >= 0 && _selectedIndex < pages.length,
        "Invalid index for selected page.");
    return Scaffold(
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Image(
          image: AssetImage("assets/icon/icon.png"),
          height: 50,
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
