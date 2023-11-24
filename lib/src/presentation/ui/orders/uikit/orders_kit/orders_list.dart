import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/domain/models/order/statuses/order_statuses_model.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});
  OrderController get controller => Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder(
      init: controller,
      builder: (_) => SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Obx(
          () => Column(
            children: [
              for (final status in controller.statuses.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        statusLabel(status: status),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    for (final order in controller.orders.value
                        .where((el) => el.status == status))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: OrderCard(order: order),
                      )
                  ],
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  String statusLabel({required String status}) {
    switch (status) {
      case OrderStatuses.preparing:
        return 'Готовится';
      case OrderStatuses.readyForCourier:
        return 'Ожидает выдачи';
      case OrderStatuses.done:
        return 'Готов';
      case OrderStatuses.completed:
        return 'Выполнен';
      case OrderStatuses.courier:
        return 'Доставляется';
      default:
        return 'Обрабатывается';
    }
  }
}
