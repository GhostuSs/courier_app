import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/order_card.dart';
import 'package:intl/intl.dart';

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
              for(final period in controller.ordersPeriods.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        DateFormat('dd MMMM').format(period),
                        style: theme.textTheme.headlineMedium
                            ?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    for (final order in controller.orders.value.where((el) => DateUtils.dateOnly(el.date_created!)==DateUtils.dateOnly(period)))
                      Padding(padding: EdgeInsets.only(bottom: 8),child: OrderCard(order: order),)
                  ],
                ),
            const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
