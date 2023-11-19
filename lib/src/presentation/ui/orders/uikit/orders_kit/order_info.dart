import 'package:action_slider/action_slider.dart';
import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/domain/models/order/statuses/order_statuses_model.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/merchant_item.dart';
import 'package:flutter/cupertino.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key});

  OrderController get controller => Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);

    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
      child: GetBuilder(
        init: controller,
        builder: (_) => Obx(() => Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Obx(() => controller
                          .selectedOrder.value.status !=
                      OrderStatuses.completed
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 56.h,
                        child: Stack(
                          children: [
                            ActionSlider.standard(
                              height: 56.h,
                              action: (_) async =>
                                  Get.dialog(CupertinoAlertDialog(
                                title: Text(
                                    'Вы ${controller.selectedOrder.value.status == OrderStatuses.courier ? "доставили" : "забрали"} заказ?'),
                                content: Text(
                                    'Подтвердите, что ${controller.selectedOrder.value.status == OrderStatuses.courier ? "заказ доставлен получателю" : "забрали заказ и выезжайте на адрес доставки"}'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('Подтвердить'),
                                    onPressed: () async {
                                      await controller.handleOrderStatus();
                                      Get.back();
                                      if(controller.selectedOrder.value.status==OrderStatuses.completed)Get.dialog(OrderDelivered(number:controller.selectedOrder.value.id));
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("Отмена"),
                                    isDefaultAction: true,
                                    onPressed: () => Get.back(),
                                  ),
                                ],
                              )),
                              icon: Icon(
                                Icons.add,
                                color: AppColors.white,
                              ),
                              backgroundColor:
                                  controller.selectedOrder.value.status ==
                                          OrderStatuses.courier
                                      ? AppColors.green
                                      : AppColors.red,
                              boxShadow: [],
                              toggleColor: AppColors.white,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                controller.selectedOrder.value.status ==
                                        OrderStatuses.courier
                                    ? locale.orderDelivered
                                    : locale.orderPicked,
                                style: theme.textTheme.displaySmall?.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                    letterSpacing: -0.03),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.white,
                title: Text(
                  locale.order + " № ${controller.selectedOrder.value.number}",
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ),
                actions: [
                  // InkWell(
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 16),
                  //     child: Assets.images.chat.svg(
                  //       width: 24.sp,
                  //     ),
                  //   ),
                  // )
                ],
                leading: InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20.sp,
                    color: AppColors.gray1,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: SafeArea(
                    minimum: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.gray3),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: controller.selectedOrder.value
                                                .shipping.addres_1 ??
                                            controller.selectedOrder.value
                                                .shipping.addres_2,
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black,
                                        )),
                                  ),
                                  Assets.images.location.svg(width: 24.sp),
                                ],
                              ),
                              if (controller.selectedOrder.value.customer_note
                                      .isNotEmpty ==
                                  true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.yellow2.withOpacity(0.36),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                        text: controller
                                            .selectedOrder.value.customer_note,
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black,
                                        )),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.gray3,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              children: [
                                Assets.images.ruble.svg(width: 24.sp),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "${controller.selectedOrder.value.total.round()} ₽",
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "${controller.selectedOrder.value.payment_method_title}",
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          locale.orderCart,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (final data
                            in controller.selectedOrder.value.lineItems)
                          MerchantItem(merchant: data),
                        SizedBox(height: 100.h),
                      ],
                    )),
              ),
            )),
      ),
    );
  }
}


class OrderDelivered extends StatelessWidget {
  final int number;
  const OrderDelivered({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final theme =Theme.of(context);
    Future.delayed(Duration(seconds: 2)).then((value) => Navigator.pop(context));
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Center(
        child: Container(
          constraints: BoxConstraints.expand(
            width: 200.w,
            height: 200.w,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.red.withOpacity(0.9)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.delivered.svg(width: 56.sp,),
              const SizedBox(height: 8),
              Text('Заказ № $number\nдоставлен',style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.white,
              ),)
            ],
          ),
        ),
      )
    ],));
  }
}
