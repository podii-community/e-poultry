import 'package:epoultry/pages/farm/batch/list_batches_page.dart';
import 'package:epoultry/pages/farm/dashboard_page.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/appbar_widget.dart';
import 'package:epoultry/widgets/gradient_text.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class FarmDashboardPage extends StatefulWidget {
  FarmDashboardPage({Key? key}) : super(key: key);

  @override
  State<FarmDashboardPage> createState() => _FarmDashboardPageState();
}

class _FarmDashboardPageState extends State<FarmDashboardPage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[DashboardPage(), ListBatchPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.background,
        selectedItemColor: CustomColors.primary,
        unselectedItemColor: CustomColors.secondary,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.houseLine),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.plus), label: "Manage Batch"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.userPlus), label: "E-extension"),
          BottomNavigationBarItem(
              icon: Icon(PhosphorIcons.shoppingCart), label: "Ecommerce"),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
