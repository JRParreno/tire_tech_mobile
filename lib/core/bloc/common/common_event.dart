import 'package:equatable/equatable.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/bloc/upload_id/upload_id_bloc.dart';

abstract class CommonEvent extends Equatable
    implements ProfileEvent, UploadIdEvent {
  const CommonEvent();

  @override
  List<Object> get props => [];
}

// initial state for all blocs
class InitialEvent extends CommonEvent {
  const InitialEvent();
}

class NoInternetConnectionEvent extends CommonEvent {
  const NoInternetConnectionEvent();
}
