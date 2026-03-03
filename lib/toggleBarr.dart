import 'package:flutter/material.dart';
import 'package:kbboutik_v04/pages/deliveryPage.dart';
import 'package:kbboutik_v04/pages/orderPage.dart';
import 'package:kbboutik_v04/pages/productPage.dart';
import 'package:kbboutik_v04/pages/statsPage.dart';


class Togglebarr extends StatefulWidget {
  const Togglebarr({super.key});

  @override
  State<Togglebarr> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Togglebarr> {

  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ProductPage(),
    OrderPage(),
    DeliveryPage(),
    StatsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Produits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Commandes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: "Livraison",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Stats",
          ),
        ],
      ),
    );
  }
}