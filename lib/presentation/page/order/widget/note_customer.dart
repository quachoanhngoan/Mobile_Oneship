import 'package:flutter/material.dart';
import 'package:oneship_merchant_app/config/theme/color.dart';

class NoteCustomer extends StatelessWidget {
  final String note;
  final String body;
  const NoteCustomer({
    super.key,
    required this.note,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        border: Border.all(
          color: AppColors.borderColor2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ghi chú của khách hàng',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.color373,
                    ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xffFEF4F1),
                  border: Border.all(
                    color: Color(0xffBE5230),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  note,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffBE5230),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
