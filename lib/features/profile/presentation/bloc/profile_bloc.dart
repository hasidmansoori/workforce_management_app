import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await repository.getProfile();
      result.fold(
            (failure) => emit(ProfileError("Failed to load profile")),
            (profile) => emit(ProfileLoaded(profile)),
      );
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await repository.updateProfile(event.profile);
      result.fold(
            (failure) => emit(ProfileError("Failed to update profile")),
            (profile) => emit(ProfileLoaded(profile)),
      );
    });
  }
}
