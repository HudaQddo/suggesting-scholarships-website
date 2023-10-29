// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/MyList/my_list_page.dart';
import 'package:frontend/Personal/profile_page.dart';
import '../../consts.dart';
import '../data/drawer_items.dart';
import '../model/drawer_item.dart';
import '../page/testing_page.dart';
import '../provider/navigation_provider.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  // _NavigationDrawerWidgetState({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      width: isCollapsed ? 80 : null,
      child: Drawer(
        child: Container(
          // color: Pallete.backgroundColor,
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              // Header of Sidebar (Logo)
              Container(
                padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: buildHeader(isCollapsed),
              ),
              SizedBox(height: 24),
              // Items Sidebar
              buildList(items: itemsFirstInSidebar, isCollapsed: isCollapsed),
              SizedBox(height: 24),
              Divider(color: Colors.white70),
              SizedBox(height: 24),
              buildList(
                indexOffset: itemsFirstInSidebar.length,
                items: itemsSecondInSidebar,
                isCollapsed: isCollapsed,
              ),
              Spacer(),
              // Collapsed Icon of Sidebar
              buildCollapseIcon(context, isCollapsed),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    navigateTo(page) {
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }

    Navigator.of(context).pop();

    switch (index) {
      case 0:
        navigateTo(ProfilePage());
        break;
      case 1:
        navigateTo(MyListPage());
        break;
      case 2:
        navigateTo(TestingPage());
        break;
      case 3:
        // navigateTo(PerformancePage());
        setState(() {
          if (colorMode == 'light') {
            colorMode = 'dark';
          } else {
            colorMode = 'light';
          }
        });
        // print(colorMode);
        // changeMode();
        // Get.isDarkMode
        //             ? Get.changeTheme(ThemeData.light())
        //             : Get.changeTheme(ThemeData.dark());
        break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final leading = Icon(icon, color: color);

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(text, style: TextStyle(color: color, fontSize: 16)),
              onTap: onClicked,
            ),
    );
  }

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(icon, color: Colors.white),
          ),
          onTap: () {
            final provider =
                Provider.of<NavigationProvider>(context, listen: false);
            provider.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) {
    return isCollapsed
        ? Container(
            padding: EdgeInsets.all(10),
            child: Image.network(
              'asset/images/logo.png',
              color: Colors.white70,
            ),
          )
        : Row(
            children: [
              SizedBox(width: 24),
              Image.network(
                'asset/images/logo.png',
                color: Colors.white70,
                width: 50,
              ),
              SizedBox(width: 16),
              Text(
                websiteTitle,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          );
  }
}
