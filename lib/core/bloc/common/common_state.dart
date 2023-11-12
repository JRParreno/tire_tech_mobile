import 'package:equatable/equatable.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_services/presentation/bloc/home_carousel/home_carousel_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:tire_tech_mobile/features/home/search_shops/presentation/bloc/shop_review_bloc/shop_review_bloc.dart';

abstract class CommonState extends Equatable
    implements
        ProfileState,
        UploadIdState,
        ShopState,
        ShopReviewState,
        HomeCarouselState {
  const CommonState();
  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialState extends CommonState {
  const InitialState();
}

// loading state for all blocs
class LoadingState extends CommonState {
  const LoadingState();
}

class ErrorState extends CommonState {
  final String error;
  const ErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class NoInternetConnectionState extends CommonState {
  const NoInternetConnectionState();
}

class ServerExceptionState extends CommonState {
  final String error;
  const ServerExceptionState(this.error);

  @override
  List<Object> get props => [error];
}

class TimeoutExceptionState extends CommonState {
  final String error;
  const TimeoutExceptionState(this.error);

  @override
  List<Object> get props => [error];
}
