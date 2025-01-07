import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/core/constant/app_assets.dart';
import 'package:oneship_merchant_app/presentation/page/login/cubit/auth_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/images/asset_image.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

import '../../../config/theme/color.dart';

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
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Vòng tròn ảnh
                      SizedBox(
                        width: 150, // Đặt kích thước vòng tròn
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: NetworkImageWithLoader(
                            state.userData?.avatarId ?? "",
                            isBaseUrl: true,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Thanh chữ đen
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(111),
                          bottomRight: Radius.circular(111),
                        ),
                        child: Container(
                          width: 120, // Độ rộng khớp với ảnh
                          height: 40, // Chiều cao của phần chữ
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Sửa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
