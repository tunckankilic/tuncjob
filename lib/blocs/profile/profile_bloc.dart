import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tuncjob/blocs/auth/auth_bloc.dart';
import 'package:tuncjob/models/models.dart';
import 'package:tuncjob/repositories/database/database_storage.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final DatabaseStorage _databaseStorage;
  StreamSubscription? _authSubscription;
  ProfileBloc(
      {required AuthBloc authBloc, required DatabaseStorage databaseStorage})
      : _authBloc = authBloc,
        _databaseStorage = databaseStorage,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    _authSubscription = _authBloc.stream.listen((state) {
      if (state.user is AuthUserChanged) {
        if (state.user != null) {
          add(LoadProfile(userId: state.user!.uid));
        }
      }
    });
  }

  void _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) {
    _databaseStorage.getUser(event.userId).listen((user) {
      add(
        UpdateProfile(user: user),
      );
    });
  }

  void _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) {
    emit(ProfileLoaded(user: event.user));
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
