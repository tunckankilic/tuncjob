import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:tuncjob/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<fa.User?>? _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    _userSubscription = _authRepository.user.listen((event) {
      add(AuthUserChanged(user: event!));
    });
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    emit(AuthState.authenticate(user: event.user));
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
  // AuthBloc({required AuthRepository authRepository})
  //     : _authRepository = authRepository,
  //       super(const AuthState.unknown()) {
  //   _userSubscription = _authRepository.user.listen((event) {
  //     add(AuthUserChanged(user: event!));
  //   });
  // }

  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is AuthUserChanged) {
  //     yield* _mapAuthUserChangedToState(event);
  //   }
  // }

  // Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
  //   yield AuthState.authenticate(user: event.user);
  // }

  // @override
  // Future<void> close() {
  //   _userSubscription?.cancel();
  //   return super.close();
  // }
}
