import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/controllers/order/order_controller.dart';
import 'package:courier_app/src/domain/models/order/order_response_model.dart';
import 'package:courier_app/src/presentation/ui/orders/uikit/orders_kit/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EarnAndHistoryScreen extends StatelessWidget {
  const EarnAndHistoryScreen({super.key});

  OrderController get controller => Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          locale.orders,
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
          bottom: false,
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: GetBuilder(
              init: controller,
              autoRemove: false,
              initState: (_) => controller.getHistory(),
              builder: (_) {
                return Obx(() => controller.loadingHistory.value
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints.expand(
                              width: double.infinity,
                              height: 55.h,
                            ),
                            child: CupertinoSlidingSegmentedControl(
                              backgroundColor: AppColors.gray3,
                              groupValue: controller.historyTabValue.value,
                              thumbColor: AppColors.red,
                              children: {
                                0: _CustomTab(
                                  label: locale.day,
                                  chosen: controller.historyTabValue.value == 0,
                                ),
                                1: _CustomTab(
                                  label: locale.week,
                                  chosen: controller.historyTabValue.value == 1,
                                ),
                                2: _CustomTab(
                                  label: locale.month,
                                  chosen: controller.historyTabValue.value == 2,
                                ),
                              },
                              onValueChanged: (value) =>
                                  controller.selectPeriod(value: value ?? 0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 27, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.red,
                                  size: 16.sp,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    _dateSelector(),
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.red,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${earnHandler()}' ' ₽',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 36.sp,
                                    color: AppColors.black),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              for (final day in controller.historyPeriods.value
                                  .where((element) =>
                                      _conditionHandler(date: element)))
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Text(
                                        DateFormat('dd MMMM').format(day),
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                    for (final data in controller.history.value
                                        .where((element) =>
                                            DateUtils.dateOnly(
                                                element.date_created!) ==
                                            DateUtils.dateOnly(day)))
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: OrderCard(
                                          order: data,
                                        ),
                                      )
                                  ],
                                )
                            ],
                          ),
                        ],
                      ));
              },
            ),
          )),
    );
  }

  String _dateSelector() {
    final dateTime = DateTime.now();
    final formatter = DateFormat('dd MMMM');
    switch (controller.historyTabValue.value) {
      case 0:
        return formatter.format(dateTime);
      case 1:
        return '${formatter.format(mostRecentMonday(dateTime))} - ${formatter.format(findLastDateOfTheWeek(dateTime))}';
      case 2:
        return '${formatter.format(findFirstDateOfTheMonth(dateTime))} - ${formatter.format(findLastDateOfTheMonth(dateTime))}';
      default:
        return '';
    }
  }

  bool _conditionHandler({required DateTime date}) {
    final current = DateUtils.dateOnly(DateTime.now());
    if (controller.historyTabValue.value == 1)
      return current.isAfter(mostRecentMonday(current)) &&
              current.isBefore(findLastDateOfTheWeek(current)) ||
          current.isAtSameMomentAs(findLastDateOfTheWeek(current)) ||
          current.isAtSameMomentAs(mostRecentMonday(current));
    if (controller.historyTabValue.value == 2)
      return current.isAfter(findFirstDateOfTheMonth(current)) &&
          current.isBefore(findLastDateOfTheMonth(current));
    return true;
  }

  int earnHandler() {
    final currentDay = DateUtils.dateOnly(DateTime.now());
    List<OrderResponseModel> orders = controller.history.value.where((element) {
      if (controller.historyTabValue.value == 0)
        return DateUtils.dateOnly(element.date_created!) == currentDay;
      if (controller.historyTabValue.value == 1)
        return element.date_created!.isAfter(mostRecentMonday(currentDay)) &&
                element.date_created!
                    .isBefore(findLastDateOfTheWeek(DateTime.now())) ||
            element.date_created!
                .isAtSameMomentAs(findLastDateOfTheWeek(currentDay)) ||
            element.date_created!
                .isAtSameMomentAs(mostRecentMonday(currentDay));
      if (controller.historyTabValue.value == 2)
        return element.date_created!
                .isAfter(findFirstDateOfTheMonth(currentDay)) &&
            element.date_created!
                .isBefore(findLastDateOfTheMonth(DateTime.now()));
      return false;
    }).toList();
    var sum = 0.0;
    for (final order in orders) {
      sum += order.total;
    }

    return (sum * 0.1).toInt();
  }

  DateTime mostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));
  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  DateTime findLastDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 0);
  }

  DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month);
  }
}

class _CustomTab extends StatelessWidget {
  final bool chosen;
  final String label;
  const _CustomTab({required this.chosen, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tab(
      child: Text(
        label,
        style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 13.sp,
          fontWeight: chosen ? FontWeight.w500 : FontWeight.w600,
          color: chosen ? AppColors.white : AppColors.gray1,
        ),
      ),
    );
  }
}
