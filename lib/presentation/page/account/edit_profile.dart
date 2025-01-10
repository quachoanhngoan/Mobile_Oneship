import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/helper/validate.dart';
import 'package:oneship_merchant_app/presentation/page/account/widget/avatar_user.dart';
import 'package:oneship_merchant_app/presentation/page/account/widget/phone_edit_profile.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController name;
  String? avatarId;

  @override
  void initState() {
    name = TextEditingController(
        text: context.read<AuthCubit>().state.userData?.name ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: SafeArea(
                child: AppButton(
                  isLoading: state.updateProfileState.isLoading,
                  isEnable: true,
                  onPressed: () {
                    FocusScope.of(context).unfocus();

                    context
                        .read<AuthCubit>()
                        .updateProfile(name.text, avatarId);
                  },
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  borderSide: const BorderSide(color: AppColors.primary),
                  text: "Lưu",
                ),
              ),
            ),
            appBar: const AppBarAuth(
              title: 'Thông tin tài khoản',
              isShowHelpButton: false,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    AvatarUser(
                      imageUrl: avatarId,
                      avatarId: (value) {
                        avatarId = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        AppTextFormField(
                          isRequired: false,
                          enabled: true,
                          hintText: 'Họ và tên',
                          controller: name,
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
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                builder: (_) {
                                  return PhoneEditProfile(
                                      phone: state.userData?.phone ?? "");
                                });
                          },
                          isRequired: false,
                          enabled: false,
                          hintText: 'Số điện thoại',
                          initialValue:
                              formatPhone(state.userData?.phone ?? ""),
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
                          initialValue:
                              state.userData?.email ?? "Chưa cập nhật",
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
                          borderSide:
                              const BorderSide(color: AppColors.primary),
                          text: "Đổi mật khẩu",
                        )
                      ],
                    )
                  ],
                ),
              ),
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
