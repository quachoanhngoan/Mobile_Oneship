import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';
import 'bottom_cubit.dart';
import 'bottom_tab.dart';

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomCubit, BottomTab>(builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 0.3,
                  offset: const Offset(0, -4),
                ),
              ],
              color: AppColors.white),
          child: BottomNavigationBar(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.colorFA6,
            unselectedItemColor: AppColors.color390,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: BottomTab.values
                .map((tab) => BottomNavigationBarItem(
                      label: "",
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          state == tab ? tab.icon(true) : tab.icon(false),
                          const SizedBox(height: 7),
                          Text(tab.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: state == tab
                                          ? AppColors.colorFA6
                                          : AppColors.color390,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700))
                        ],
                      ),
                    ))
                .toList(),
            onTap: (index) {
              context.read<BottomCubit>().updateTab(BottomTab.values[index]);
            },
          ),
        ),
        body: state.screen(context),
      );
    });
  }
}
