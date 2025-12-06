import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hommie/helpers/loading_helper.dart';
import 'package:hommie/models/user_login_model.dart';
import 'package:hommie/view/home.dart';

class LoginScreenController extends GetxController {
  
  var logingfirsttime = false;
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();
  //final api = Get.find<ApiLogin>();
  final key = GlobalKey<FormState>();

  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  Future<void> login() async {
    if (!key.currentState!.validate()) {
      return;
    }

    final user = UserLoginModel(
      email: userEmailController.text,
      password: passwordController.text,
    );

    isLoading.value = true;
    LoadingHelper.show();
    await Future.delayed(const Duration(seconds: 2));

    LoadingHelper.hide();
    isLoading.value = false;
    Get.snackbar('Success', 'Logged in successfully');
    
    if (logingfirsttime == true) {
      logingfirsttime = false;
    } else {
      Get.offAll(() => Home());
    }

    /*try {
      final response = await api.loginuser(user);

      LoadingHelper.hide();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;

        String token = data['access'];
        String refreshToken = data['refresh'];

        final box = GetStorage();
        box.write('access_token', token);
        box.write('refresh_token', refreshToken);
        
        Get.snackbar('Success', 'Logged in successfully');
        
        if (logingfirsttime == true) {
          logingfirsttime = false;
        } else {
          Get.offAll(() => Home());
        }
      } else {
        Get.snackbar("Error", "Login failed: ${response.body.toString()}");
      }
    } catch (e) {
      LoadingHelper.hide();
      Get.snackbar('Error', 'Something went wrong! $e');
    }*/
  }

  @override
  void onClose() {
    userEmailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}