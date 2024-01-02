part of 'onboarding_bloc.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingLoaded extends OnboardingState {
  final User user;
  const OnboardingLoaded({required this.user});
  @override
  // TODO: implement props
  List<Object> get props => [user];
}
