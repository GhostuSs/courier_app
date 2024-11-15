import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/services/secure_storage/secure_storage_service.dart';
import 'package:courier_app/src/presentation/ui/auth/auth_screen.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/earn_and_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: RawButton(
      //     label: locale.needHelp,
      //     onTap: () {},
      //     active: true,
      //     customColor: AppColors.gray2,
      //     invertTextColor: true,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24,),
                Text(
                  locale.profile,
                  style: theme.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: _logout,
                  child: Icon(Icons.exit_to_app,color: AppColors.black,size: 24,),
                )
              ],
            ),
            const SizedBox(height: 24),
            InkWell(
              child: InkWell(
                onTap: () => Get.bottomSheet(
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top),
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(10.r)),
                        child: const EarnAndHistoryScreen(),
                      ),
                    ),
                    isScrollControlled: true,
                    isDismissible: true),
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: const BoxConstraints.tightFor(
                    width: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray3,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.forkandknife.svg(
                            width: 23.sp,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'История заказов и доход',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.gray1,
                        size: 24.sp,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _logout(){
    SecureStorage.clearData();
    Get.to(const AuthScreen());
  }
}
