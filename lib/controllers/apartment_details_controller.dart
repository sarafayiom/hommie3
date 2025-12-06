import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hommie/models/apartment_model.dart';

class ApartmentDetailsController extends GetxController {
  late ApartmentModel apartment;
  final bool isTenant = true;
  late RxBool isFavorite; 
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is ApartmentModel) {
      apartment = Get.arguments as ApartmentModel;
      isFavorite = apartment.isFavorite.obs;
    } else {
      Get.back();
      Get.snackbar("Error", "Apartment details not found");
    }
  }

  void toggleFavorite() async {
    if (isLoading.value) return; 
    isLoading.value = true;
    bool newState = !isFavorite.value;

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      isFavorite.value = newState;
      apartment.isFavorite = newState;

      Get.snackbar(
        "Favorites",
        newState ? "Apartment added to favorites" : "Apartment removed from favorites",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

    } catch (e) {
      print("Error updating favorite: $e");
      Get.snackbar(
        "Connection Error",
        "Unable to save favorite status. Please try again later.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void bookApartment() {
    if (isTenant) {
      print("Booking started for ${apartment.title}");
    } else {
      Get.snackbar("Access Denied", "Only tenants can book apartments.");
    }
  }
}
