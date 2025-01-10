// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oneship_merchant_app/injector.dart';
// import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';
// import 'package:oneship_merchant_app/presentation/page/menu_search/menu_search_cubit.dart';
// import 'package:oneship_merchant_app/presentation/page/menu_search/menu_search_state.dart';

// import '../../../config/theme/color.dart';
// import '../../widget/text_field/text_field_base.dart';
// import '../menu_diner/domain/menu_domain.dart';
// import '../menu_diner/menu_diner_cubit.dart';
// import '../menu_diner/menu_diner_page.dart';
// import '../topping_custom/topping_custom.dart';
// import '../menu_diner/menu_diner_state.dart';

// class MenuSearchSheet extends StatefulWidget {
//   final List<DataMenuTypeDomain> listMenu;

//   const MenuSearchSheet({super.key, required this.listMenu});

//   @override
//   State<MenuSearchSheet> createState() => _MenuSearchSheetState();
// }

// class _MenuSearchSheetState extends State<MenuSearchSheet> {
//   late MenuSearchCubit bloc;

//   @override
//   void initState() {
//     bloc = injector.get<MenuSearchCubit>();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MenuSearchCubit, MenuSearchState>(
//         bloc: bloc,
//         builder: (context, state) {
//           return Scaffold(
//             body: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     IconButton(
//                         onPressed: () {
//                           context.popScreen();
//                         },
//                         icon: const Icon(Icons.arrow_back,
//                             color: AppColors.black)),
                    // Expanded(
                    //     child: TextFieldBase(
                    //   hintText: "Tìm kiếm sản phẩm",
                    //   suffix: const Icon(Icons.search, size: 16),
                    //   prefix: IconButton(
                    //       onPressed: () {},
                    //       icon: const Icon(Icons.clear_outlined, size: 16)),
                    // ))
//                   ],
//                 ),
//                 Row(
//                   children: List.generate(MenuMainType.values.length, (index) {
//                     final item = MenuMainType.values[index];
//                     return Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           bloc.changeMainPage(item);
//                         },
//                         child: Container(
//                           color: AppColors.transparent,
//                           child: Column(
//                             children: <Widget>[
//                               SizedBox(
//                                 height: 34,
//                                 child: Text(
//                                   item.title,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall
//                                       ?.copyWith(
//                                           color: state.menuMainType == item
//                                               ? AppColors.color988
//                                               : AppColors.textGray,
//                                           fontWeight: state.menuMainType == item
//                                               ? FontWeight.w600
//                                               : FontWeight.w500),
//                                 ),
//                               ),
//                               Container(
//                                 height: state.menuMainType == item ? 3 : 1,
//                                 color: state.menuMainType == item
//                                     ? AppColors.color988
//                                     : AppColors.textGray,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//                 SizedBox(
//                   height: 40,
//                   width: double.infinity,
//                   child: ListView.builder(
//                       itemCount: MenuType.values.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         final item = MenuType.values[index];
//                         final titleCount = widget.listMenu
//                                 .where((e) => e.type == item)
//                                 .toList()
//                                 .firstOrNull
//                                 ?.data
//                                 ?.length ??
//                             0;
//                         return Row(
//                           children: <Widget>[
//                             GestureDetector(
//                               onTap: () {
//                                 bloc.changPageMenu(item);
//                               },
//                               child: IntrinsicWidth(
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12),
//                                   child: Text(
//                                     item.title.replaceAll(
//                                         RegExp(r'#VALUE'), '$titleCount'),
//                                     textAlign: TextAlign.center,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall
//                                         ?.copyWith(
//                                             color: item == state.menuType
//                                                 ? AppColors.color988
//                                                 : AppColors.textGray,
//                                             fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             index != MenuType.values.length - 1
//                                 ? const VerticalDivider(
//                                     color: AppColors.textGray,
//                                     thickness: 1,
//                                     width: 1,
//                                     indent: 8,
//                                     endIndent: 8,
//                                   )
//                                 : Container()
//                           ],
//                         );
//                       }),
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }

// class _ResultMenuWidget extends StatelessWidget {
//   final MenuSearchCubit bloc;
//   final MenuSearchState state;

//   const _ResultMenuWidget({super.key, required this.bloc, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: state.listResultSearch.length,
//         itemBuilder: (context, index) {
//           final item = state.listResultSearch[index];
//           return CardDetailMenu(
//             item: item,
//             actionWidget: SizedBox(
//               height: 40,
//               child: Row(
//                 children:
//                     List.generate(DetailMenuActionType.values.length, (index) {
//                   final itemAction = DetailMenuActionType.values[index];
//                   return Expanded(
//                     flex: itemAction == DetailMenuActionType.more ? 2 : 5,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           right: DetailMenuActionType.values.length - 1 != index
//                               ? 8
//                               : 0),
//                       child: GestureDetector(
//                         onTap: () {
//                           switch (itemAction) {
//                             case DetailMenuActionType.advertisement:
//                               log("advertisement click");
//                             case DetailMenuActionType.hide:
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return DialogChangeStatus(
//                                       done: (isOk) {
//                                         if (isOk) {
//                                           bloc.hideOrShowMenuFood(item,
//                                               isHide: true,
//                                               productCategoryId:
//                                                   listItem[index].id);
//                                         }
//                                         context.popScreen();
//                                       },
//                                       title: "Thay đổi trạng thái",
//                                       listSubTitle: [
//                                         "Bạn có chắc chắn muốn ẩn món ",
//                                         "\"${item.name}\"",
//                                         " trên ứng dụng khách hàng không?"
//                                       ],
//                                     );
//                                   });
//                             case DetailMenuActionType.edit:
//                               bloc.getDetailFoodById(item.id);
//                               break;
//                             case DetailMenuActionType.more:
//                               break;
//                           }
//                         },
//                         child: Container(
//                             alignment: Alignment.center,
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: AppColors.transparent,
//                                 border: Border.all(
//                                     color: itemAction.colorBorder, width: 1),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: itemAction.title != null
//                                 ? Text(
//                                     itemAction.title!,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall
//                                         ?.copyWith(
//                                             fontWeight: FontWeight.w600,
//                                             fontSize: 12,
//                                             color: itemAction.colorText),
//                                   )
//                                 : const Padding(
//                                     padding: EdgeInsets.only(top: 8),
//                                     child: Icon(
//                                       Icons.more_horiz_rounded,
//                                       size: 16,
//                                     ),
//                                   )),
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           );
//         });
//   }
// }

// class _ResultGroupToppingWidget extends StatelessWidget {
//   final MenuSearchCubit bloc;
//   final MenuSearchState state;

//   const _ResultGroupToppingWidget(
//       {super.key, required this.bloc, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
