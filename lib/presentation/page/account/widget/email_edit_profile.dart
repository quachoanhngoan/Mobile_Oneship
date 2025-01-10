import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/presentation/data/extension/context_ext.dart';

import '../../../../config/theme/color.dart';
import '../../../widget/appbar/appbar_common.dart';
import '../../register/register_cubit.dart';
import '../../register/register_state.dart';

class EmailEditProfile extends StatefulWidget {
  final String email;
  const EmailEditProfile({super.key, required this.email});

  @override
  State<EmailEditProfile> createState() => _EmailEditProfileState();
}

class _EmailEditProfileState extends State<EmailEditProfile> {
  late PageController pageController;
  late final FocusNode _phoneNode;

  int indexPage = 0;
  var titleAppBar = "Email";
  var emailUser = "email";

  @override
  void initState() {
    pageController = PageController();
    _phoneNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBarAuth(
            title: titleAppBar,
            onPressed: () {
              if (indexPage == 0) {
                context.popScreen();
              } else {
                pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              }
            }),
        body: Column(
          children: <Widget>[
            indexPage != 0
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Expanded(
                          child: AnimatedContainer(
                            margin: const EdgeInsets.only(right: 5),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInCubic,
                            height: 6,
                            decoration: BoxDecoration(
                                color: indexPage >= index + 1
                                    ? AppColors.color988
                                    : AppColors.color8E8,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      }),
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value){
                setState(() {
                  indexPage = value;
                  switch (indexPage) {
                    case 1:
                      titleAppBar = "Cập nhật email";
                      break;
                    case 2:
                      titleAppBar = "Nhập mã xác thực OTP";
                      break;
                    case 3:
                      titleAppBar = "Xác thực OTP";
                      break;
                    default:
                      titleAppBar = "Cập nhật email";
                      break;
                  }
                });
              },
              children: <Widget>[
                _CurrentEmailPage(email: widget.email)
              ],
            ))
          ],
        ),
      );
    });
  }
}

class _CurrentEmailPage extends StatelessWidget {
  final String email;
  const _CurrentEmailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

