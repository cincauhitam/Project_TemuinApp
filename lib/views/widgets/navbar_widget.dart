import 'package:flutter/material.dart';
import '../../data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return ValueListenableBuilder(
          valueListenable: isDarkMode, // <-- Add your dark mode notifier here
          builder: (context, isDarkMode, _) {
            final Color iconColor = isDarkMode
                ? const Color.fromARGB(1000, 239, 230, 222) // light icons
                : const Color.fromARGB(1000, 154, 0, 2);    // dark red icons

            final Color navColor = isDarkMode
                ? const Color.fromARGB(1000, 154, 0, 2)     // dark background
                : const Color.fromARGB(1000, 239, 230, 222); // light background

            return NavigationBarTheme(
              data: const NavigationBarThemeData(
                indicatorColor: Colors.transparent,
              ),
              child: NavigationBar(
                height: 70 + MediaQuery.of(context).padding.bottom,
                backgroundColor: navColor,
                destinations: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: NavigationDestination(
                      icon: Icon(Icons.person_2_rounded, size: 35, color: iconColor),
                      label: "",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: NavigationDestination(
                      icon: Icon(Icons.groups_2_outlined, size: 35, color: iconColor),
                      label: "",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: NavigationDestination(
                      icon: Icon(Icons.run_circle_outlined, size: 65, color: iconColor),
                      label: "",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: NavigationDestination(
                      icon: Icon(Icons.home_filled, size: 35, color: iconColor),
                      label: "",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: NavigationDestination(
                      icon: Icon(Icons.post_add, size: 35, color: iconColor),
                      label: "",
                    ),
                  ),
                ],
                onDestinationSelected: (int value) {
                  selectedPageNotifier.value = value;
                },
                selectedIndex: selectedPage,
              ),
            );
          },
        );
      },
    );
  }
}
