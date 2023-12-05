import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/empty_order.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/orders_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  OrderController get controller => Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.getOrders(),
        child: SafeArea(
          minimum: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
          ),
          child: GetBuilder(
            init: controller,
            autoRemove: false,
            initState: (_) async => await controller.initialize(),
            builder: (_) => Obx(() => Column(
                  children: [
                    Text(
                      locale.orders,
                      style: theme.textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    controller.loadingOrders.value
                        ? Expanded(
                            child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          ))
                        : Expanded(
                            child: controller.orders.value.isEmpty
                                ? const EmptyOrder()
                                : const OrdersList(),
                          )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
