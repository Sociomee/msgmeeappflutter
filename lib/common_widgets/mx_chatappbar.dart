import 'package:flutter/material.dart';

import '../theme/colors.dart';

class MxChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MxChatAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.centerTitle,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: elevation ?? 0,
      leadingWidth: 35,
      titleSpacing: 0,
      title: title,
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
