import 'package:bmi/features/screens/home_page/home_page_controller.dart';
import 'package:get/get.dart';

class HomePageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>HomePageController());
  }
}