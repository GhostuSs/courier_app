import 'package:courier_app/res/barrels/barrel.dart';
import 'package:courier_app/src/domain/models/cart/merchant_item_model.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

class MerchantItem extends StatelessWidget {
  final CartModel merchant;
  const MerchantItem({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  width: 116.w,
                  height: 110.h,
                  color: AppColors.gray3,
                  child: FastCachedImage(url: merchant.image,
                    gaplessPlayback: true,
                    width: 116.w,height: 110.h,errorBuilder: (_,c,s)=>Center(
                      child: Assets.images.merchantPlaceholder.svg(width: 48.w),
                    ),),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(
                    text: merchant.name,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AppColors.black,
                    ),
                  ),),
                  const SizedBox(height: 4),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(merchant.total.round().toString()+' ₽',style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: AppColors.black,
                      ),),
                      Text(merchant.quantity.toString()+' шт',style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: AppColors.gray1,
                      ),),
                    ],
                  ),

                ],
              ),),
            ],
          )
        ],
      ),
    );
  }
}
