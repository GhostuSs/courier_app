import 'package:courier_app/res/barrels/barrel.dart';

class RawButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;
  final Color? customColor;
  final bool? invertTextColor;
  const RawButton({super.key, required this.label, required this.onTap, required this.active, this.customColor, this.invertTextColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        constraints: BoxConstraints.expand(height: 56.h),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: customColor ?? (active ? AppColors.red :AppColors.redFocus),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,style: theme.textTheme.headline3?.copyWith(
              color: active ? invertTextColor==true ? AppColors.black :AppColors.white :AppColors.white.withOpacity(0.5)
            ),),
          ],
        ),
      ),
    );
  }
}
