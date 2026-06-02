import 'package:flutter/material.dart';

class MainNavigationScreen extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onDestinationSelected;
  final VoidCallback? onOpenModes;

  const MainNavigationScreen({
    super.key,
    this.currentIndex = 0,
    this.onDestinationSelected,
    this.onOpenModes,
  });

  void _handleTap(int index) {
    if (index == 1 && onOpenModes != null) {
      onOpenModes!.call();
      return;
    }
    onDestinationSelected?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: _handleTap,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view_rounded),
          label: 'Modes',
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          selectedIcon: Icon(Icons.history),
          label: 'History',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
