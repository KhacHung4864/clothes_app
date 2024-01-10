import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardFragmentsScreen extends GetView<DashboardFragmentsController> {
  const DashboardFragmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.backButtonPressCount.value == 1) {
          Future.delayed(Duration.zero, () {
            SystemNavigator.pop();
          });
        } else {
          controller.backButtonPressCount.value = 1;
          showError('Press back again to exit');
          Future.delayed(const Duration(seconds: 2), () {
            controller.backButtonPressCount.value = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(child: Obx(() => controller.fragmentScreen[controller.currentIndexs.value])),
        backgroundColor: Palette.black,
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: controller.currentIndexs.value,
              onTap: (value) {
                controller.currentIndexs.value = value;
                controller.tabBottomBar();
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Palette.white,
              unselectedItemColor: Palette.white24,
              items: List.generate(4, (index) {
                var navbtn = controller.navigationButton[index];
                return BottomNavigationBarItem(
                  backgroundColor: Palette.black,
                  icon: Icon(navbtn['non_active_icon']),
                  activeIcon: Icon(navbtn['active_icon']),
                  label: navbtn['label'],
                );
              }),
            )),
      ),
    );
  }
}
