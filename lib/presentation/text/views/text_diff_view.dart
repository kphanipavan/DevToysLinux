import 'package:dev_widgets/infrastructure/global_settings.dart';
import 'package:dev_widgets/presentation/text/controllers/text_diff_controller.dart';
import 'package:dev_widgets/presentation/widgets/default_app_bar.dart';
import 'package:dev_widgets/presentation/widgets/io_editor/input_editor.dart';
import 'package:dev_widgets/presentation/widgets/multi_split_view_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class TextDiffView extends GetView<TextDiffController> {
  const TextDiffView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(title: controller.tool.homeTitle),
        body: SizedBox(
          height: Get.height - kToolbarHeight,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: YaruSection(headline: "configuration".tr, children: [
                  Obx(
                    () => RadioListTile<DiffCleanupType>(
                        title: Text("semantic_cleanup".tr),
                        subtitle: Text("semantic_cleanup_description".tr),
                        value: DiffCleanupType.SEMANTIC,
                        groupValue: controller.diffCleanupType.value,
                        onChanged: (DiffCleanupType? value) {
                          controller.diffCleanupType.value = value;
                        }),
                  ),
                  Obx(
                    () => RadioListTile(
                        title: Row(
                          children: [
                            Text(
                                "${"efficiency_cleanup".tr}.${"edit_cost".tr}:"),
                            SizedBox(
                                width: 40,
                                height: 30,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    controller.editCost.value =
                                        int.tryParse(value) ?? 4;
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    border: OutlineInputBorder(),
                                  ),
                                ))
                          ],
                        ),
                        subtitle: Text("efficiency_cleanup_description".tr),
                        value: DiffCleanupType.EFFICIENCY,
                        groupValue: controller.diffCleanupType.value,
                        onChanged: (DiffCleanupType? value) {
                          controller.diffCleanupType.value = value;
                        }),
                  ),
                  Obx(
                    () => RadioListTile(
                        title: Text("no_cleanup".tr),
                        subtitle: Text("no_cleanup_description".tr),
                        value: DiffCleanupType.NONE,
                        groupValue: controller.diffCleanupType.value,
                        onChanged: (DiffCleanupType? value) {
                          controller.diffCleanupType.value = value;
                        }),
                  ),
                ]),
              ),
              SizedBox(
                  height: Get.height / 3,
                  child: MultiSplitViewTheme(
                    data: MultiSplitViewThemeData(dividerThickness: 5),
                    child: MultiSplitView(
                      dividerBuilder: (axis, index, resizable, dragging,
                              highlighted, themeData) =>
                          MultiSplitViewDivider(
                              dragging: dragging, highlighted: highlighted),
                      axis: Axis.horizontal,
                      children: [
                        InputEditor(
                            toolbarTitle: "old_text".tr,
                            inputController: controller.oldTextController,
                            height: Get.height / 3,
                            usesCodeControllers: false),
                        InputEditor(
                            toolbarTitle: "new_text".tr,
                            height: Get.height / 3,
                            inputController: controller.newTextController,
                            usesCodeControllers: false),
                      ],
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Text("difference".tr,
                          style: Get.theme.textTheme.titleMedium,
                          textAlign: TextAlign.start),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.theme.disabledColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: Get.height / 3,
                      width: Get.width,
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Obx(
                          () => PrettyDiffText(
                              textAlign: TextAlign.left,
                              diffEditCost: controller.editCost.value,
                              diffCleanupType:
                                  controller.diffCleanupType.value ??
                                      DiffCleanupType.SEMANTIC,
                              defaultTextStyle: TextStyle(
                                  fontSize:
                                      GlobalSettings.getTextEditorFontSize(),
                                  textBaseline: TextBaseline.alphabetic,
                                  fontFamily:
                                      GlobalSettings.getTextEditorFontFamily(),
                                  color: Get.theme.textTheme.bodyText1!.color),
                              newText: controller.newText.value,
                              oldText: controller.oldText.value),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
