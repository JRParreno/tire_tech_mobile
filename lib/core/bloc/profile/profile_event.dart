part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class SetProfileEvent extends ProfileEvent {
  final Profile profile;

  const SetProfileEvent({
    required this.profile,
  });

  @override
  List<Object?> get props => [profile];
}

class SetProfileLogoutEvent extends ProfileEvent {}

class SetProfilePicture extends ProfileEvent {
  final String profilePhoto;

  const SetProfilePicture(this.profilePhoto);

  @override
  List<Object?> get props => [profilePhoto];
}
