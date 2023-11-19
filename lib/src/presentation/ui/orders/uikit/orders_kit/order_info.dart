import 'package:action_slider/action_slider.dart';
import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/merchant_item.dart';


class OrderInfo extends StatelessWidget {
  final OrderResponseModel order;
  const OrderInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {

    final locale = AppLocale.of(context);
    final theme = Theme.of(context);

    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ActionSlider.standard(
            height: 56.h,
            action: (_)=>print('actions'),
            icon: Icon(Icons.add,color: AppColors.white,),
            backgroundColor: AppColors.red,
            boxShadow: [],
            toggleColor: AppColors.white,
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Text(
            locale.order + " № ${order.number}",
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          actions: [
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Assets.images.chat.svg(
                  width: 24.sp,
                ),
              ),
            )
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: order.shipping?.addres_1 ??
                                      order.shipping.addres_2,
                                  style: theme.textTheme.displayMedium?.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black,
                                  )),
                            ),
                            Assets.images.location.svg(width: 24.sp),
                          ],
                        ),
                        if (order.customer_note.isNotEmpty == true)
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.yellow2.withOpacity(0.36),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                  text: order.customer_note,
                                  style: theme.textTheme.displayMedium?.copyWith(
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
                                      text: "${order.total.round()} ₽",
                                      style:
                                      theme.textTheme.displayMedium?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                        color: AppColors.black,
                                      ))),
                              RichText(
                                text: TextSpan(
                                    text: "${order.payment_method_title}",
                                    style:
                                    theme.textTheme.displayMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                      color: AppColors.black,
                                    )),
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
                  for(final data in order.lineItems)
                    MerchantItem(merchant: data)
                ],
              )),
        ),
      ),
    );
  }
}
