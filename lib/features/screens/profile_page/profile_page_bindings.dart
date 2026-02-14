import 'package:bmi/features/screens/profile_page/profile_page_controller.dart';
import 'package:get/get.dart';

class ProfilePageBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>ProfilePageController());
  }

}