import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/empty_order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  OrderController get controller => Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
        ),
        child: GetBuilder(init:controller,initState:(_)=>controller.initialize(),builder:(_)=>Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              locale.orders,
              style: theme.textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            EmptyOrder()
          ],
        ),
        ),
      ),
    );
  }
}
