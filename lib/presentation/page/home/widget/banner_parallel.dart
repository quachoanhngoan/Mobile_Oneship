import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/core/core.dart';

class BannerParallel extends StatefulWidget {
  const BannerParallel({
    super.key,
  });

  @override
  State<BannerParallel> createState() => _BannerParallelState();
}

class _BannerParallelState extends State<BannerParallel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Đề xuất cho bạn",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const Spacer(),
            Text("Xem tất cả",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: const Color(0xffEB8564),
                      fontSize: 14,
                    )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _BannerItem(),
              SizedBox(
                width: 10,
              ),
              _BannerItem(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BannerItem extends StatelessWidget {
  const _BannerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 148,
            width: 173,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(AppAssets.imagesBannerr2),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chương trình siêu Sale 30% cho tất cả sản phẩm",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: const Color(0xff2D2D2D),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 153,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffEB8564),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("Xem ngay",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color(0xffEB8564),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
