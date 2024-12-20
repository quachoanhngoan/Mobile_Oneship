import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/presentation/page/store/cubit/store_cubit.dart';
import 'package:oneship_merchant_app/presentation/page/store/widget/store_item.dart';

class StoresApprove extends StatelessWidget {
  const StoresApprove({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const CupertinoActivityIndicator();
            }
            if (state.getStoresApproveCount == 0) {
              return Container(
                alignment: Alignment.center, // use aligment
                child: Image.asset(
                  AppAssets.imagesStoresEmpty,
                  height: 180,
                  width: 180,
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                bottom: 100,
                top: 12,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.getStoresApproveCount,
              itemBuilder: (context, index) {
                final item = state.getStoresApprove[index];
                return StoreItem(
                  data: item,
                );
              },
            );
          },
        ));
  }
}
