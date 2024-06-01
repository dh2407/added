import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NvAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showCloseBtn;

  const NvAppBar({
    Key? key,
    this.showCloseBtn = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(92);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 92,
      backgroundColor: const Color(0xFFF5F6FB),
      automaticallyImplyLeading: false,
      actions: [
        if (showCloseBtn)
          Container(
            width: 48,
            height: 48,
            margin: const EdgeInsets.only(left: 16),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F434BB4),
                  blurRadius: 8,
                  offset: Offset(1, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Color(0xFF676CAC),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
      ],
      centerTitle: true,
    );
  }
}
