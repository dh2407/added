import 'package:added/app/data/models/models.dart';
import 'package:added/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubSubjectBoxComponent extends StatelessWidget {
  final SubSubject subSubject;

  const SubSubjectBoxComponent({
    super.key,
    required this.subSubject,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.FLASH_CARD, arguments: subSubject);
      },
      child: Container(
        width: 77,
        height: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Center(
          child: Text(
            subSubject.title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
