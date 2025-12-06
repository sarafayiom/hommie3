
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StartupscreenController extends GetxController {
  Rx waiting = true.obs;
   final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 4), () {
    // waiting.value = false;
   //  if (box.hasData('access_token')) {
        Get.offNamed("welcome");
   //   } else {
   //     Get.off(() => SignUp());
    //  }
    });
  }
    }