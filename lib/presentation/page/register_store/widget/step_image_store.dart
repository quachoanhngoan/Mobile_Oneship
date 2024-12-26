import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';
import 'package:oneship_merchant_app/presentation/widget/images/form_upload_image.dart';

class StepImageStore extends StatelessWidget {
  final RegisterStoreCubit bloc;
  const StepImageStore({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                _AvatarStore(bloc: bloc),
                const SizedBox(height: 20),
                _AvatarCoverStore(bloc: bloc),
                const SizedBox(height: 20),
                _AvatarFontIStore(bloc: bloc),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AvatarCoverStore extends StatelessWidget {
  const _AvatarCoverStore({
    super.key,
    required this.bloc,
  });

  final RegisterStoreCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: "Ảnh bìa cửa hàng",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: AppColors.color054,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: " *",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.error, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.info_outline,
              color: AppColors.color2B3,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
          bloc: bloc,
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FormUploadImage(
                title: "960 x 500px. Tối đa 1MB",
                initialImage: state.storeCoverId,
                onUploadedImage: (value) {
                  bloc.setStoreCoverId(value);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AvatarStore extends StatelessWidget {
  const _AvatarStore({
    required this.bloc,
  });

  final RegisterStoreCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //            description: "Ảnh đại diện",
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: "Ảnh đại diện",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: AppColors.color054,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: " *",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.error, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.info_outline,
              color: AppColors.color2B3,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.2,
          child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
            bloc: bloc,
            builder: (context, state) {
              return FormUploadImage(
                initialImage: state.storeAvatarId,
                title: "550 x 550px. Tối đa 1MB",
                onUploadedImage: (value) {
                  bloc.setStoreAvatarId(value);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AvatarFontIStore extends StatelessWidget {
  const _AvatarFontIStore({
    required this.bloc,
  });

  final RegisterStoreCubit bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //            description: "Ảnh đại diện",
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Ảnh mặt tiền",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: AppColors.color054,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " *",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.error, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.color2B3,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return FormUploadImage(
                      initialImage: state.storeFrontId,
                      title: "550 x 550px. Tối đa 1MB",
                      onUploadedImage: (value) {
                        bloc.setStoreFrontId(value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //            description: "Ảnh đại diện",
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Ảnh thực đơn",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: AppColors.color054,
                          ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " *",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.error, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.color2B3,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return FormUploadImage(
                      initialImage: state.storeMenuId,
                      title: "550 x 550px. Tối đa 1MB",
                      onUploadedImage: (value) {
                        bloc.setStoreMenuId(value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
