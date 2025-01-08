import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/helper/validate.dart';
import 'package:oneship_merchant_app/presentation/page/account/widget/avatar_user.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field%20copy.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppBarAuth(
            title: 'Thông tin tài khoản',
            isShowHelpButton: false,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const AvatarUser(),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    AppTextFormField(
                      isRequired: false,
                      enabled: false,
                      hintText: 'Họ và tên',
                      initialValue: state.userData?.name ?? "Chưa cập nhật",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppTextFormField(
                      isRequired: false,
                      enabled: false,
                      hintText: 'Vai trò',
                      filled: true,
                      initialValue: "Chủ quán",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextFormField(
                      onTap: () {
                        print("Chuyển sang quên mật khẩu");
                        //TODO : Chuyển sang quên mật khẩu
                      },
                      isRequired: false,
                      enabled: false,
                      hintText: 'Số điện thoại',
                      initialValue: formatPhone(state.userData?.phone ?? ""),
                      suffix: IconButton(
                          onPressed: () {},
                          icon: const ImageAssetWidget(
                              image: AppAssets.imagesIconsArrowRight01,
                              width: 20)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppTextFormField(
                      onTap: () {
                        //TODO : Chuyển sang quên mật khẩu
                      },
                      isRequired: false,
                      enabled: false,
                      hintText: 'Email',
                      initialValue: state.userData?.email ?? "Chưa cập nhật",
                      suffix: IconButton(
                          onPressed: () {},
                          icon: const ImageAssetWidget(
                              image: AppAssets.imagesIconsArrowRight01,
                              width: 20)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppButton(
                      isEnable: true,
                      onPressed: () {
                        // Get.toNamed(AppRoutes.changePassword);
                      },
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: Colors.white,
                      textColor: AppColors.primary,
                      borderSide: const BorderSide(color: AppColors.primary),
                      text: "Đổi mật khẩu",
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String formatPhone(String phone) {
    // if (phone.length < 10) {
    //   return phone;
    // }
    final phone2 = ValidateHelper.phoneFormat(phone);
    if (phone2 == "") {
      return "";
    }
    return '${phone2.substring(0, 3)} ${phone2.substring(3, 6)} ${phone2.substring(6, 9)} ${phone2.substring(9)}';
  }
}
