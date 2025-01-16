import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/config/routes/app_router.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/constant/dimensions.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/gr_topping_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/domain/menu_domain.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_page.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/widgets/dashed_divider.dart';
import 'package:oneship_merchant_app/presentation/page/topping_custom/topping_custom.dart';

class ToppingNotRegisteredBody extends StatelessWidget {
  final List<GrAddToppingResponse> listItem;
  final MenuDinerCubit bloc;
  final MenuDinerState state;

  const ToppingNotRegisteredBody(
      {super.key,
      required this.bloc,
      required this.listItem,
      required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isShowSearch) {
      final listResultSearch = state.listResultSearchTopping
          .firstWhereOrNull((e) => e.type == ToppingType.notRegistered);
      if (listResultSearch?.data != null &&
          listResultSearch!.data!.isNotEmpty) {
        return _ItemGrToppingNotRegister(
          showItemClick: (value) {
            bloc.hideOrShowTopping(value, isHide: false);
          },
          listItem: listResultSearch.data!,
          editItemClick: (value) {
            Get.toNamed(AppRoutes.menuCustomTopping, arguments: value)
                ?.then((value) {
              if (value) {
                bloc.getAllTopping();
              }
            });
          },
          removeItemClick: (value) {
            bloc.deleteGroupTopping(value.id);
          },
        );
      }
      return const EmptySearchMenu();
    }
    return _ItemGrToppingNotRegister(
      showItemClick: (value) {
        bloc.hideOrShowTopping(value, isHide: false);
      },
      listItem: listItem,
      editItemClick: (value) {
        Get.toNamed(AppRoutes.menuCustomTopping, arguments: value)
            ?.then((value) {
          if (value) {
            bloc.getAllTopping();
          }
        });
      },
      removeItemClick: (value) {
        bloc.deleteGroupTopping(value.id);
      },
    );
  }
}

class _ItemGrToppingNotRegister extends StatelessWidget {
  final List<GrAddToppingResponse> listItem;
  final Function(GrAddToppingResponse) showItemClick;
  final Function(GrAddToppingResponse) editItemClick;
  final Function(GrAddToppingResponse) removeItemClick;
  const _ItemGrToppingNotRegister(
      {required this.listItem,
      required this.editItemClick,
      required this.removeItemClick,
      required this.showItemClick});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listItem.length,
        padding: const EdgeInsets.only(top: 20),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.color8E8),
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      listItem[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 24,
                    )
                  ],
                ),
                const VSpacing(spacing: 8),
                const DashedDivider(color: AppColors.color8E8),
                const VSpacing(spacing: 12),
                SizedBox(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogChangeStatus(
                                    done: (isOk) {
                                      if (isOk) {
                                        showItemClick(listItem[index]);
                                        // bloc.hideOrShowTopping(listItem[index],
                                        //     isHide: false);
                                      }
                                      Get.back();
                                    },
                                    title: "Thay đổi trạng thái",
                                    listSubTitle: [
                                      "Bạn có chắc chắn muốn hiển thị nhóm topping ",
                                      "\"${listItem[index].name}\"",
                                      " trên ứng dụng khách hàng không?"
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.transparent,
                                border: Border.all(color: AppColors.color8E8)),
                            child: Text(
                              "Hiển thị",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      const HSpacing(spacing: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            editItemClick(listItem[index]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.transparent,
                                border: Border.all(color: AppColors.colorD33)),
                            child: Text(
                              "Sửa",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.colorD33),
                            ),
                          ),
                        ),
                      ),
                      const HSpacing(spacing: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogChangeStatus(
                                    done: (isOk) {
                                      if (isOk) {
                                        removeItemClick(listItem[index]);
                                      }
                                      Get.back();
                                    },
                                    title: "Thay đổi trạng thái",
                                    listSubTitle: [
                                      "Bạn có muốn xoá nhóm topping ",
                                      "\"${listItem[index].name}\"",
                                      " trên ứng dụng khách hàng không?"
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.transparent,
                                border: Border.all(color: AppColors.color8E8)),
                            child: Text(
                              "Xoá",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
