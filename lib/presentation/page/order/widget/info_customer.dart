import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/widget/images/network_image_loader.dart';

enum Role { customer, driver }

class InfoCustomer extends StatelessWidget {
  final String? name;
  final String? avatar;
  final String? phone;
  final Widget? suffix;
  final Role role;
  late final String nameText;
  InfoCustomer({
    super.key,
    this.name,
    this.avatar,
    this.phone = "--",
    this.suffix,
    this.role = Role.customer,
  }) {
    if (name != null) {
      nameText = role == Role.customer ? 'Khách hàng: ' : 'Tài xế: ';
    } else {
      nameText = role == Role.customer ? 'Chưa có tên' : 'Chưa có tài xế';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                SizedBox(
                    width: 50,
                    height: 50,
                    child: NetworkImageWithLoader(
                      avatar ?? "",
                      isBaseUrl: true,
                      isAuth: true,
                      fit: BoxFit.contain,
                    )),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(builder: (context) {
                        return RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: nameText,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                              children: <TextSpan>[
                                if (name != null)
                                  TextSpan(
                                    text: ' ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff909194),
                                        ),
                                  ),
                                if (name != null)
                                  TextSpan(
                                    text: name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff909194),
                                        ),
                                  ),
                              ]),
                        );
                      }),
                      Text(
                        phone!,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.description,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
