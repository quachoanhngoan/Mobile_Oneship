import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/button/app_button.dart';
import 'package:oneship_merchant_app/presentation/widget/images/form_upload_image.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

class AvatarUser extends StatelessWidget {
  final ValueChanged<String> avatarId;
  final String? imageUrl;
  const AvatarUser({
    super.key,
    required this.avatarId,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          // Hiển thị bottom sheet
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _ChangeAvatarItem(
                    title: 'Xem ảnh',
                    onTap: () {
                      Get.back();
                      if (BlocProvider.of<AuthCubit>(context)
                              .state
                              .userData
                              ?.avatarId ==
                          null) {
                        dialogService.showAlertDialog(
                          context: context,
                          title: "Thông báo",
                          description: "Chưa có ảnh đại diện",
                          onPressed: () => Get.back(),
                          buttonTitle: "Đóng",
                        );
                        return;
                      }
                      Get.dialog(
                        Dialog(
                          alignment: Alignment.center,
                          backgroundColor: Colors.white,
                          child: NetworkImageWithLoader(
                            BlocProvider.of<AuthCubit>(context)
                                    .state
                                    .userData
                                    ?.avatarId ??
                                "",
                            isBaseUrl: true,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _ChangeAvatarItem(
                    title: 'Chỉnh sửa ảnh',
                    onTap: () {
                      Get.back();
                      Get.dialog(
                        Dialog(
                          alignment: Alignment.center,
                          backgroundColor: Colors.transparent,
                          child: StatefulBuilder(builder: (context, setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    FormUploadImage(
                                      height: 300,
                                      initialImage:
                                          BlocProvider.of<AuthCubit>(context)
                                              .state
                                              .userData
                                              ?.avatarId,
                                      onUploadedImage: avatarId,
                                      title: 'Chọn ảnh đại diện',
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                AppButton(
                                  isEnable: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  margin: const EdgeInsets.only(top: 10),
                                  text: 'Xác nhận',
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _ChangeAvatarItem(
                    title: 'Xóa ảnh',
                    onTap: () {
                      Get.back();
                      dialogService.showAlertDialog(
                        context: context,
                        title: "Xoá ảnh",
                        description: "Bạn có chắc chắn muốn xóa ảnh đại diện?",
                        onPressed: () {
                          avatarId("");
                          Get.back();
                        },
                        onCancel: () => Get.back(),
                        buttonColor: Colors.red,
                        buttonTitle: "Xoá",
                        buttonCancelTitle: "Hủy",
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Vòng tròn ảnh
            SizedBox(
              width: 80, // Đặt kích thước vòng tròn
              height: 80,
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Builder(builder: (context) {
                      if (imageUrl == null &&
                          state.userData?.avatarId == null) {
                        return Image.network(
                          "https://i.pinimg.com/736x/89/90/48/899048ab0cc455154006fdb9676964b3.jpg",
                          fit: BoxFit.cover,
                        );
                      }
                      return NetworkImageWithLoader(
                        imageUrl ?? state.userData?.avatarId ?? "",
                        isBaseUrl: true,
                        fit: BoxFit.cover,
                      );
                    }),
                  );
                },
              ),
            ),
            // Thanh chữ đen
            ClipOval(
              child: Container(
                width: 80, // Đảm bảo vừa khít với vòng tròn
                height: 80, // Khớp với kích thước hình tròn
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 22, // Chiều cao của phần chữ
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Text(
                    'Sửa',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeAvatarItem extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  const _ChangeAvatarItem({
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderColor2,
              width: 1,
            ),
          ),
        ),
        child: Text(title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
      ),
    );
  }
}
