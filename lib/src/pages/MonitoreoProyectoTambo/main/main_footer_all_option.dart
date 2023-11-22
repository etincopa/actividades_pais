import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Monitor/monitoring_list_page.dart';
import 'package:flutter/material.dart';
import 'Components/custom_bottom_bar.dart';

import 'package:actividades_pais/custom_background.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/project_list_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Settings/main_footer_setting_page.dart';

class MainFooterAllOptionPage extends StatefulWidget {
  const MainFooterAllOptionPage({super.key});

  @override
  _MainFooterAllOptionPageState createState() =>
      _MainFooterAllOptionPageState();
}

class _MainFooterAllOptionPageState extends State<MainFooterAllOptionPage>
    with TickerProviderStateMixin<MainFooterAllOptionPage> {
  late TabController bottomTabController;

  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    bottomTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        painter: MainBackground(),
        child: TabBarView(
          controller: bottomTabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ProjectListPage(),
            MonitorList(estadoM: "ALL"),
            MainFooterSettingPage(),
          ],
        ),
      ),
    );
  }
}
