import 'package:bmi/features/screens/splash_page/splash_page_controller.dart';
import 'package:get/get.dart';

class SplashPageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>SplashPageController());
  }
}