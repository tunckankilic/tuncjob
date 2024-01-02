import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuncjob/blocs/onboarding/onboarding_bloc.dart';
import 'package:tuncjob/screens/onboarding/widgets/widgets.dart';

class Demo extends StatelessWidget {
  final TabController tabController;

  Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(text: 'What\'s Your Gender?'),
                    const SizedBox(height: 20),
                    CustomCheckbox(
                      text: 'MALE',
                      value: state.user.gender == "Male",
                      onChanged: (bool? p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(gender: "Male"),
                              ),
                            );
                      },
                    ),
                    CustomCheckbox(
                      text: 'FEMALE',
                      value: state.user.gender == "Female",
                      onChanged: (bool? p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(gender: "Female"),
                              ),
                            );
                      },
                    ),
                    CustomCheckbox(
                      text: 'OTHER',
                      value: state.user.gender == "Other",
                      onChanged: (bool? p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(gender: "Other"),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 100),
                    const CustomTextHeader(text: 'What\'s Your Age?'),
                    CustomTextField(
                      hint: 'ENTER YOUR AGE',
                      textEditingController: textEditingController,
                      onChanged: (p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(age: int.parse(p0)),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 3,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).colorScheme.background,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        tabController: tabController, text: 'NEXT STEP'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
