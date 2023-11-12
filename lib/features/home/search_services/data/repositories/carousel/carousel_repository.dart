import 'package:tire_tech_mobile/features/home/search_services/data/models/carousel.dart';

abstract class CarouselRepository {
  Future<List<Carousel>> fetchCarousel();
}
