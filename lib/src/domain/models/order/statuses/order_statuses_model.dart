abstract class OrderStatuses{
  /// Изготавливается
  static const String preparing = 'wc-making';
  /// Ожидает выдачи
  static const String readyForCourier = 'wc-wait-stock';
  /// Готов
  static const String done = 'wc-done';
  /// Выполнен
  static const String completed = 'wc-completed';

// "wc-processing": "Обработка",
// "wc-making": "Изготавливается",
// "wc-done": "Готов",
// "wc-wait-stock": "Ожидает выдачи",
// "wc-kurier": "Курьер выехал",
// "wc-completed": "Выполнен",
// "wc-cancelled": "Отменен",
// "wc-pending": "Ожидание оплаты",
// "wc-on-hold": "На Удержании",
// "wc-refunded": "Возврат",
// "wc-failed": "Не удался",
// "wc-checkout-draft": "Черновик"
}