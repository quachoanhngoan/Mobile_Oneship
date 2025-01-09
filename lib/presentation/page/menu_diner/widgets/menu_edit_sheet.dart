import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
import 'package:oneship_merchant_app/presentation/data/model/menu/linkfood_response.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';
import 'package:oneship_merchant_app/presentation/widget/text_field/app_text_form_field%20copy.dart';

import '../menu_diner_cubit.dart';

class MenuEditSheet extends StatefulWidget {
  final MenuDinerCubit bloc;
  final ItemLinkFood item;
  const MenuEditSheet({super.key, required this.bloc, required this.item});

  @override
  State<MenuEditSheet> createState() => _MenuEditSheetState();
}

class _MenuEditSheetState extends State<MenuEditSheet> {
  late MenuDinerCubit _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    _bloc.nameMenuEditController.text = widget.item.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuDinerCubit, MenuDinerState>(
        bloc: _bloc,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.white,
                  surfaceTintColor: AppColors.white,
                  leading: IconButton(
                      onPressed: () {
                        context.popScreen();
                      },
                      icon:
                          const Icon(Icons.arrow_back, color: AppColors.black)),
                  title: Text("Chỉnh sửa",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ),
                body: Column(
                  children: <Widget>[
                    const VSpacing(spacing: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppTextFormField(
                        isRequired: false,
                        controller: _bloc.nameMenuEditController,
                        hintText: "Tên danh mục",
                        // initialValue: widget.item.name,
                        onChanged: (value) {
                          _bloc.validateNameGrMenuEdit();
                        },
                        suffix: state.showClearNameEditMenu
                            ? GestureDetector(
                                onTap: () {
                                  _bloc.nameMenuEditController.clear();
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 16,
                                  color: AppColors.black.withOpacity(0.6),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 0.3,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      child: GestureDetector(
                        onTap: () {
                          _bloc.editMenuGroupName(widget.item.id);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.color988,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Lưu thông tin",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Visibility(
              //   visible: state.isLoading,
              //   child: const LoadingWidget(),
              // )
            ],
          );
        });
  }
}
