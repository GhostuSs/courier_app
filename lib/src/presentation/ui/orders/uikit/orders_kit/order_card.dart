import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/domain/models/order/short_order_response_model/short_order_response_model.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/order_info.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final ShortOrderResponseModel order;
  const OrderCard({super.key, required this.order});
  OrderController get controller => Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        controller.selectOrder(order: controller.orders.firstWhereOrNull((element) => element.id==order.id) ?? controller.history.value.firstWhere((element) => element.id==order.id));
        Get.bottomSheet(
          const OrderInfo(),
          isScrollControlled: true,
          ignoreSafeArea: false,
        );
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.gray3, borderRadius: BorderRadius.circular(10.r)),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.tightFor(width: double.infinity),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Assets.images.forkandknife.svg(width: 15.sp),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd MMMM yyyy г. в hh:mm').format(order.date_created),
                    style: theme.textTheme.headline2?.copyWith(
                        fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: -0.06),
                  ),
                  Text(
                    '${order.order_products_count} блюда на ' + (order.order_total).toInt().toString() + '₽',
                    style: theme.textTheme.headline2?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray1,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Text(
                '${(order.courier_payment).toInt()}₽',
                style: theme.textTheme.headline2?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              )
            ]),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class OrderCardFull extends StatelessWidget {
  final OrderResponseModel order;
  const OrderCardFull({super.key, required this.order});
  OrderController get controller => Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        controller.selectOrder(order: controller.orders.firstWhereOrNull((element) => element.id==order.id) ?? controller.history.value.firstWhere((element) => element.id==order.id));
        Get.bottomSheet(
          const OrderInfo(),
          isScrollControlled: true,
          ignoreSafeArea: false,
        );
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.gray3, borderRadius: BorderRadius.circular(10.r)),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.tightFor(width: double.infinity),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Assets.images.forkandknife.svg(width: 15.sp),
              const SizedBox(width: 12),
              if (order.date_created != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy г. в hh:mm').format(order.date_created!),
                      style: theme.textTheme.headline2?.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.black, letterSpacing: -0.06),
                    ),
                    Text(
                      '${order.lineItems.length} блюда на ' + (order.total).toInt().toString() + '₽',
                      style: theme.textTheme.headline2?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray1,
                      ),
                    )
                  ],
                ),
              const Spacer(),
              // Text(
              //   '${(order.total).toInt()}₽',
              //   style: theme.textTheme.headline2?.copyWith(
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.w700,
              //     color: AppColors.black,
              //   ),
              // )
            ]),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}