import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hommie/controllers/apartment_details_controller.dart';
import 'package:hommie/utils/app_colors.dart';
import 'package:hommie/widgets/rating_stars_widget.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  const ApartmentDetailsScreen({super.key});

  Widget _buildDetailIcon(IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApartmentDetailsController controller = Get.find<ApartmentDetailsController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
        );
      }

      final apartment = controller.apartment;

      return Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.backgroundLight,
              leading: Container(
                margin: const EdgeInsets.only(left: 10, top: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.backgroundLight),
                  onPressed: () => Get.back(),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 10, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      apartment.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.backgroundLight,
                    ),
                    onPressed: () {
                      controller.toggleFavorite();
                    },
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  height: 300,
                  child: PageView.builder(
                    itemCount: apartment.imageUrls.isNotEmpty ? apartment.imageUrls.length : 1,
                    itemBuilder: (context, index) {
                      if (apartment.imageUrls.isEmpty) {
                        return const Center(
                            child: Icon(Icons.image_not_supported, size: 80));
                      }
                      return Image.network(
                        apartment.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              apartment.title,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimaryLight),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RatingStarsWidget(rating: apartment.avgRating),
                              const SizedBox(height: 4),
                              Text(
                                '${apartment.avgRating.toString()} / 5',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textSecondaryLight),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 20, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              '${apartment.address}, ${apartment.city}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.textPrimaryLight,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              apartment.governorate,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              size: 20, color: AppColors.textSecondaryLight),
                          const SizedBox(width: 8),
                          Text(
                            'Owner: ${apartment.ownerName}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondaryLight,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),

                      const Divider(
                          height: 35,
                          thickness: 1,
                          color: AppColors.textSecondaryLight),
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryLight),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        apartment.description,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondaryLight,
                            height: 1.5),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Key Details',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimaryLight),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColors.textSecondaryLight.withOpacity(0.2),
                              width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textPrimaryLight.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildDetailIcon(Icons.meeting_room_sharp, 'Rooms',
                                apartment.roomsCount.toString()),
                            _buildDetailIcon(Icons.square_foot, 'Area',
                                '${apartment.apartmentSize} m²'),
                            _buildDetailIcon(Icons.attach_money, 'Price/Day',
                                '\$${apartment.pricePerDay.toStringAsFixed(0)}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
        bottomNavigationBar: controller.isTenant
            ? Container(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Price / Day',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.textSecondaryLight),
                        ),
                        Text(
                          '\$${apartment.pricePerDay.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: controller.bookApartment,
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 18, color: AppColors.backgroundLight),
                        label: const Text(
                          'Book Now',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.backgroundLight),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 25),
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      );
    });
  }
}
