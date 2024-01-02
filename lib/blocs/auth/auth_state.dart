part of 'auth_bloc.dart';

enum AuthStatus { unknown, unAuthenticate, authenticate }

class AuthState extends Equatable {
  final AuthStatus status;
  final fa.User? user;
  const AuthState._({this.status = AuthStatus.unknown, this.user});
  const AuthState.unknown() : this._();
  const AuthState.authenticate({required fa.User user})
      : this._(status: AuthStatus.authenticate, user: user);
  const AuthState.unAuthenticate() : this._(status: AuthStatus.unAuthenticate);

  @override
  List<Object?> get props => [status, user];
}
