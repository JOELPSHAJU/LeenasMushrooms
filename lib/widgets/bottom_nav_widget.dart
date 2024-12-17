import 'package:flutter/material.dart';
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

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _selectedIndex = 0;
  final List<String> _titles = [
    "HomePage",
    "Call Details",
    "Order Details",
    "INC/EXP"
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
