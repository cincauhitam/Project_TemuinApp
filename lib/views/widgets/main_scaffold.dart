import 'package:flutter/material.dart';
import 'package:project_flutter/data/notifiers.dart';
import 'package:project_flutter/views/widgets/drawer_widget.dart';
import 'package:project_flutter/views/widgets/navbar_widget.dart';
import 'package:project_flutter/views/widgets/appbar_widget.dart';


 

class MainScaffold extends StatelessWidget {
  final Widget body;
  const MainScaffold({super.key,required this.body});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, darkMode, child) {
        return Scaffold(
          appBar: AppBarWidget(),
          body: body,
          drawer: const DrawerWidget(),
          bottomNavigationBar: const NavbarWidget(),
        );
      },
    );
  }
}