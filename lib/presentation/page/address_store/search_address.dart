import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/injector.dart';
import 'package:oneship_merchant_app/presentation/data/model/search.model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/presentation/widget/appbar/appbar_common.dart';
import 'package:oneship_merchant_app/presentation/widget/images/images.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({super.key});

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final StoreRepository repository = injector.get<StoreRepository>();
  final ValueNotifier<List<Features>>? features =
      ValueNotifier<List<Features>>([]);
  var isEmpty = false;

  Future<void> searchAddress(String query) async {
    isLoading.value = true;
    final response = await execute(
      () => repository.searchAddress(query: query),
      isShowFailDialog: true,
    );
    response.when(
      success: (data) {
        if (data.features!.isNotEmpty) {
          features!.value = data.features!;
        } else {
          isEmpty = true;
          setState(() {});
        }
      },
    );
    // isLoading.value = false;
  }

  Timer? timer;
  void debounce(Function() action) {
    if (timer != null) {
      timer!.cancel();
    }
    const duration = Duration(milliseconds: 500);
    timer = Timer(duration, action);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: const AppBarAuth(
            title: "Nhập địa chỉ",
            isShowHelpButton: false,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FormEditAddress(
                  (value) {
                    if (value.isEmpty) {
                      if (timer != null) {
                        timer!.cancel();
                      }
                      features!.value = [];
                      return;
                    }
                    if (value.length < 2) {
                      if (timer != null) {
                        timer!.cancel();
                      }
                      return;
                    }

                    debounce(() {
                      searchAddress(value);
                    });
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: features!,
                  builder: (context, value, child) {
                    if (isEmpty) {
                      return Container(
                        constraints: BoxConstraints(
                          minHeight: 400.h,
                        ),
                        margin: EdgeInsets.only(top: 16.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageAssetWidget(
                                image: AppAssets.imagesIconsLocationSlash,
                                width: 100,
                                height: 100),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Không tìm thấy kết quả cho từ khóa này. Bạn có thể thử tìm kiếm từ khóa khác nhé!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff45484F)),
                            ),
                          ],
                        ),
                      );
                    }
                    if (features!.value.isEmpty && !isLoading.value) {
                      return Container(
                        constraints: BoxConstraints(
                          minHeight: 400.h,
                        ),
                        margin: EdgeInsets.only(top: 16.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ImageAssetWidget(
                                image: AppAssets.imagesIconsLocation,
                                width: 100,
                                height: 100),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Nhập địa chỉ của bạn để hiển thị danh sách gợi ý",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff45484F)),
                            ),
                          ],
                        ),
                      );
                    }
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "Kết quả tìm kiếm",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.only(top: 16.h),
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 20,
                                color: Color(0xffE0E3E6),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: features!.value.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                      context, features!.value[index]);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const ImageAssetWidget(
                                          image: AppAssets
                                              .imagesIconsCurrentLocation,
                                          width: 20,
                                          height: 20),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              features!.value[index].text!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.textColor),
                                            ),
                                            Text(
                                              features!.value[index].placeName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.color373),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}

class _FormEditAddress extends StatelessWidget {
  //on changed
  final Function(String) onChanged;
  const _FormEditAddress(this.onChanged);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
      },
      child: TextFormField(
        enabled: true,
        onChanged: onChanged,
        cursorHeight: 16,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
        autocorrect: false,
        decoration: InputDecoration(
          isDense: true,

          filled: false,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 10.w),
            child: const ImageAssetWidget(
                image: AppAssets.imagesIconsSearchAlt1, width: 15, height: 15),
          ),

          hintText: "Nhập địa chỉ của bạn",
          fillColor: const Color(0xffF9FAFB),
          contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          // hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w500,
          //       color: AppColors.color373,
          //     ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),

          // hintText: 'Nhập họ và tên người đại diện',
        ),
      ),
    );
  }
}
