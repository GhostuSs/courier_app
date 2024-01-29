enum OrdersFilter{
  day,
  week,
  month
}

extension OrdersFilterExtension on OrdersFilter{
  int fromEnumToTabValue(){
    switch(this){
      case OrdersFilter.day:return 0;
      case OrdersFilter.week:return 1;
      case OrdersFilter.month:return 2;
    }
  }
}

extension IntegerExtension on int{
  OrdersFilter fromIntToEnum({required int value}){
    switch(value){
      case 0:return OrdersFilter.day;
      case 1:return OrdersFilter.week;
      case 2:return OrdersFilter.month;
      default:return OrdersFilter.day;
    }
  }
}