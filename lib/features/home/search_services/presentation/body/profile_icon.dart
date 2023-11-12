import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/profile/profile_bloc.dart';
import 'package:tire_tech_mobile/features/account/profile/presentation/screens/profile_screen.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(ProfileScreen.routeName),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return CircleAvatar(
                  backgroundImage: state.profile?.profilePhoto != null
                      ? NetworkImage(
                          state.profile!.profilePhoto!,
                          scale: 30,
                        )
                      : null,
                  radius: 25,
                  child: state.profile?.profilePhoto != null
                      ? null
                      : const Icon(
                          Icons.person,
                          size: 20,
                        ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
