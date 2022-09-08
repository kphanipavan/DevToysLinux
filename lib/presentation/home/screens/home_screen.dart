import 'package:devtoys/presentation/widgets/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:layout/layout.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tools = controller.getAllTools();

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'all_tools'.tr,
        style: TextStyle(fontSize: 18),
      )),
      body: SingleChildScrollView(
          child: GridView.builder(
        itemCount: tools.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: context.layout.value(xs: 1.5, sm: 2, md: 2.5, lg: 3, xl: 3.5),
          crossAxisCount: context.layout.value(xs: 1, sm: 2, md: 3, lg: 4, xl: 3),
        ),
        itemBuilder: (BuildContext context, int index) {
          return MenuCard(
              icon: tools[index].icon, text: tools[index].name, onTap: () {});
        },
      )),
    );
  }
}
