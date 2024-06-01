import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sub_subject_page_controller.dart';

class SubSubjectPageView extends GetView<SubSubjectPageController> {
  const SubSubjectPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubSubjectPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubSubjectPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
