import 'package:flutter/material.dart';
import '../../data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return ValueListenableBuilder(
          valueListenable: isDarkMode,
          builder: (context, dark, _) {
            final iconColor = dark ? Color.fromARGB(255, 239, 230, 222) : Color.fromARGB(255, 154, 0, 2);
            final navBg = dark ? Color.fromARGB(255, 29, 29, 29) : Color.fromARGB(255, 239, 230, 222);
            return NavigationBarTheme(
              data: NavigationBarThemeData(indicatorColor: Colors.transparent),
              child: NavigationBar(
                height: 70 + MediaQuery.of(context).padding.bottom,
                backgroundColor: navBg,
                destinations: [
                  Padding(padding: EdgeInsets.only(top: 30), child: NavigationDestination(icon: Icon(Icons.person_2_rounded, size: 35, color: iconColor), label: '')),
                  Padding(padding: EdgeInsets.only(top: 30), child: NavigationDestination(icon: Icon(Icons.groups_2_outlined, size: 35, color: iconColor), label: '')),
                  Padding(padding: EdgeInsets.only(top: 14), child: NavigationDestination(icon: Icon(Icons.run_circle_outlined, size: 65, color: iconColor), label: '')),
                  Padding(padding: EdgeInsets.only(top: 30), child: NavigationDestination(icon: Icon(Icons.home_filled, size: 35, color: iconColor), label: '')),
                  Padding(padding: EdgeInsets.only(top: 30), child: NavigationDestination(icon: Icon(Icons.post_add, size: 35, color: iconColor), label: '')),
                ],
                onDestinationSelected: (int value) { selectedPageNotifier.value = value; },
                selectedIndex: selectedPage,
              ),
            );
          },
        );
      },
    );
  }
}
