import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:store_pro/product_store/views/icecream_view.dart';
import 'package:store_pro/product_store/views/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SearchView(),

      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Ionicons.ice_cream_outline), 
          label: 'Home'
        ),
    
        NavigationDestination(
          icon: Icon(Ionicons.search_outline), 
          label: 'Search'
        ),
    
        NavigationDestination(
          icon: Icon(Ionicons.cart_outline), 
          label: 'Cart'
        )
      ],
    );
  }
}
