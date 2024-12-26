import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/config/config.dart';
import 'package:oneship_merchant_app/presentation/page/register_store/cubit/register_store_cubit.dart';

class TermsAndConditionsPage extends StatelessWidget {
  //onAcceptTermsAndConditions
  final RegisterStoreCubit bloc;
  const TermsAndConditionsPage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(
                      title: 'Vui lòng chuẩn bị các giấy tờ liên quan'),
                  SizedBox(height: 10),
                  _SectionContent(
                    content:
                        'Vui lòng xem các giấy tờ liên quan khi điền trang thông tin đại diện.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: 'Thông tin, giấy tờ cần chuẩn bị'),
                  SizedBox(height: 5),
                  _SectionList(
                    items: [
                      'CCCD/Hộ chiếu người đại diện quán',
                      'Giấy đăng ký hộ kinh doanh cá thể (nếu có)',
                      'Ảnh chụp thực đơn/danh sách món ăn kèm giá, ảnh đại diện, ảnh từng món ăn & ảnh mặt tiền quán',
                      'Thông tin tài khoản ngân hàng để đăng ký thanh toán tự động',
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(
                      title: 'Vui lòng đọc kỹ điều khoản và điều kiện'),
                  const SizedBox(height: 5),
                  SectionAgreement(
                    bloc: bloc,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Mulish',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xff121212),
      ),
    );
  }
}

class _SectionContent extends StatelessWidget {
  final String content;

  const _SectionContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Mulish',
        color: AppColors.textGrayBold,
      ),
    );
  }
}

class _SectionList extends StatelessWidget {
  final List<String> items;
  final EdgeInsetsGeometry padding;
  const _SectionList(
      {required this.items, this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          if (item.contains("SẢN PHẨM BỊ CẤM")) {
            //richText for SẢN PHẨM BỊ CẤM
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  const SizedBox(
                    height: 22,
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: AppColors.textGrayBold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 14,
                          color: AppColors.textGrayBold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'Bằng việc tiếp tục đăng ký, Đối tác đồng ý sẽ chịu toàn bộ trách nhiệm pháp lý liên quan đến việc đăng bán các ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGrayBold,
                            ),
                          ),
                          TextSpan(
                            text: 'SẢN PHẨM BỊ CẤM',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              color: Color(0xff107953),
                            ),
                          ),
                          TextSpan(
                            text: ' trên OneShip.',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textGrayBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8,
                ),
                const SizedBox(
                  height: 22,
                  child: Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.textGrayBold,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'Mulish',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGrayBold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class SectionAgreement extends StatelessWidget {
  //onAcceptTermsAndConditionsVAlue
  final RegisterStoreCubit bloc;
  const SectionAgreement({
    super.key,
    required this.bloc,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<RegisterStoreCubit, RegisterStoreState>(
              bloc: bloc,
              builder: (context, state) {
                return Checkbox(
                  checkColor: Colors.white,
                  side: const BorderSide(color: AppColors.primary),
                  activeColor: AppColors.primary,
                  visualDensity: VisualDensity.compact,
                  value: state.isAcceptTermsAndConditions,
                  onChanged: (value) {
                    if (value == null) return;
                    bloc.setAcceptTermsAndConditions(value);
                  },
                );
              },
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Tôi xác nhận rằng đã đọc tất cả điều khoản và điều kiện nêu trên và đồng ý ký hợp đồng với OneShip với các mục phí để trở thành đối tác chính thức của OneShip:',
                  style: TextStyle(
                    fontFamily: 'Mulish',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textGrayBold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const _SectionList(
          padding: EdgeInsets.only(left: 34),
          items: [
            'Phí hoa hồng 25% với mỗi đơn hàng được giao thành công, OneShip thu 25% phí hoa hồng và thanh toán cho Quý Đối Tác khoản còn lại.',
            'Trong vòng 7 ngày kể từ khi đăng ký gian hàng thành công, OneShip thu 25% phí hoàn tất việc ký hợp đồng hợp tác với OneShip. Nếu quá thời hạn trên, yêu cầu đăng ký sẽ bị hủy.',
            'Bằng việc tiếp tục đăng ký, Đối tác đồng ý sẽ chịu toàn bộ trách nhiệm pháp lý liên quan đến việc đăng bán các SẢN PHẨM BỊ CẤM trên OneShip.',
          ],
        ),
      ],
    );
  }
}
