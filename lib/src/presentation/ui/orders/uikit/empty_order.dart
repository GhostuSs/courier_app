import 'package:courier_app/res/barrels/barrel.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.oh.svg(width: 56.w),
        const SizedBox(
          height: 30,
          width: double.infinity,
        ),
        RichText(
            text: TextSpan(
              text: 'Заказов пока нет',
              style: theme.textTheme.displayMedium,
            ))
      ],
    );
  }
}
