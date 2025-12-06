import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hommie/models/apartment_model.dart';
import 'package:hommie/services/apartments_service.dart';
import 'package:hommie/view/apartment_details_screen.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final PageController pageController = PageController();

  RxInt currentIndex = 0.obs; 
  RxBool isLoading = false.obs; 
  RxList<ApartmentModel> apartments = <ApartmentModel>[].obs; 

  @override
  void onInit() {
    super.onInit();
    fetchApartments();
  }

  @override
  void onClose() {
    searchController.dispose();
    pageController.dispose();
    super.onClose();
  }

  Future<void> fetchApartments({String query = ''}) async {
    try {
      isLoading.value = true;
      if (query.isNotEmpty) {
        apartments.clear();
      }
      final List<ApartmentModel> fetchedData = await ApartmentsService.fetchApartments(query: query);
      apartments.assignAll(fetchedData);
      print(" Loaded ${fetchedData.length} apartments successfully.");
    } catch (e) {
      print(" Error in HomeController: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch() {
    fetchApartments(query: searchController.text);
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index); 
  }

  void goToApartmentDetails(ApartmentModel apartment) {
    Get.to(() => const ApartmentDetailsScreen(), arguments: apartment);
  }
}
