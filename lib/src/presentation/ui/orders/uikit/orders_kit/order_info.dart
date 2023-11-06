import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';

class OrderInfo extends StatelessWidget {
  final OrderResponseModel order;
  const OrderInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          locale.order,
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        leading: InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24.sp,
            color: AppColors.gray1,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(order.toJson().toString())
      ),
    );
  }
}
