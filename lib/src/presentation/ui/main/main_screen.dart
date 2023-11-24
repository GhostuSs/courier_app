import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  MainController get controller => Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder(
        init: controller,
        initState: (_) => controller.initialize(),
        builder: (c) => Obx(
          () => Scaffold(
            body: MainController.screens[controller.currIndex.value],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currIndex.value,
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              selectedItemColor: AppColors.black,
              onTap: (value) => controller.changeIndex(index: value),
              items: [
                BottomNavigationBarItem(
                  icon: Assets.images.ordersTab.svg(
                      color: controller.currIndex.value == 0
                          ? AppColors.black
                          : AppColors.gray1,
                      width: 24.w),
                  label: 'Заказы',
                ),
                BottomNavigationBarItem(
                  icon: Assets.images.profileTab.svg(
                    color: controller.currIndex.value == 1
                        ? AppColors.black
                        : AppColors.gray1,
                    width: 24.w,
                  ),
                  label: 'Профиль',
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
