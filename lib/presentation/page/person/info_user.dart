import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

class InfoUser extends StatelessWidget {
  const InfoUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Builder(builder: (context) {
                    if (state.userData?.avatarId == null) {
                      return CircleAvatar(
                        radius: 36,
                        backgroundColor: AppColors.primary,
                        child: ImageAssetWidget(
                          image: AppAssets.imagesIconsUserAlt2,
                          height: 36.sp,
                          color: AppColors.white,
                        ),
                      );
                    }
                    return CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white,
                      child: NetworkImageWithLoader(
                        state.userData?.avatarId ?? "",
                        radius: 300,
                        isBaseUrl: true,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 0.5.sw,
                      child: Text(
                        state.userData?.name ?? state.userData?.email ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                    Text(
                      "Chủ quán",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.colorA8A,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffEE4D2D),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        ImageAssetWidget(
                          image: AppAssets.imagesIconsStar,
                          height: 12.sp,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "5.00",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                const SizedBox(width: 20),
              ],
            ),
          ],
        );
      },
    );
  }
}
