import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tire_tech_mobile/core/config/app_constant.dart';
import 'package:tire_tech_mobile/gen/colors.gen.dart';

PreferredSizeWidget buildAppBar({
  required BuildContext context,
  String? title,
  Widget? leading,
  bool showBackBtn = false,
  List<Widget>? actions,
  Color? backgroundColor,
  Widget? titleWidget,
  double? leadingWidth,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: backgroundColor ?? ColorName.primary,
    centerTitle: titleWidget != null ? false : true,
    elevation: 0,
    automaticallyImplyLeading: false,
    leadingWidth: leadingWidth,
    leading: !showBackBtn
        ? leading ??
            IconButton(
              icon: const Icon(
                Icons.arrow_circle_left,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
        : null,
    title: titleWidget ??
        Text(
          title ?? AppConstant.appName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: .3,
          ),
        ),
    actions: actions,
  );
}
