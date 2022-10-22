import 'package:devtoys/domain/models/tools/encoders/url_encoder_tool.dart';
import 'package:devtoys/infrastructure/bindings/controllers/get_tool.dart';
import 'package:devtoys/presentation/encoders/controllers/url_encoder_controller.dart';
import 'package:get/get.dart';

class UrlEncoderControllerBinding extends Bindings {
  @override
  void dependencies() {
    final tool = getTool<UrlEncoderTool>();

    Get.lazyPut<UrlEncoderController>(() => UrlEncoderController(tool));
  }
}
