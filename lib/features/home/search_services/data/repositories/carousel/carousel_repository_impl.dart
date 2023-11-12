import 'package:tire_tech_mobile/features/home/search_services/data/models/carousel.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/carousel/carousel_repository.dart';
import 'package:tire_tech_mobile/gen/assets.gen.dart';

class CarouselRepositoryImpl extends CarouselRepository {
  @override
  Future<List<Carousel>> fetchCarousel() async {
    try {
      final carousels = [
        Carousel(
          imageUrl: Assets.images.carousel.carousel1.path,
          title: 'Vehicle Service',
          description:
              'Oil Change, Brake Service, Tire Services, Engine Diagnostics, etc.',
        ),
        Carousel(
          imageUrl: Assets.images.carousel.carousel2.path,
          title: 'Auto parts Store',
          description: 'Tires, Batteries, Oil and Lubricants, Filters, etc.',
        ),
        Carousel(
          imageUrl: Assets.images.carousel.carousel3.path,
          title: 'Carwash Service',
          description:
              'Self-Service Carwash, Automatic Carwash, Hand Wash, etc.',
        ),
      ];

      return carousels;
    } catch (e) {
      rethrow;
    }
  }
}
