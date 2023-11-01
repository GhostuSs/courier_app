import 'package:courier_app/res/barrels/barrel.dart';

class EarnAndHistoryScreen extends StatelessWidget{
  const EarnAndHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocale.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(locale.orders,style: theme.textTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),),
        leading: InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: ()=>Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_rounded,size: 24.sp,color: AppColors.gray1,),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }
}
