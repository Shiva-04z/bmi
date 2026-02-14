import 'register_page_controller.dart';
import 'package:get/get.dart';

class RegisterPageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>RegisterPageController());
  }
}