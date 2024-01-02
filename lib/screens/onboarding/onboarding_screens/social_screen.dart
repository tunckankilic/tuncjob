// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuncjob/blocs/onboarding/onboarding_bloc.dart';

import '../widgets/widgets.dart';

class Social extends StatelessWidget {
  final TabController tabController;
  Social({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  final TextEditingController textEditingController3 = TextEditingController();

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
                    const CustomTextHeader(text: 'LINKEDIN'),
                    CustomTextField(
                      hint: 'ENTER YOUR PROFILE LINK',
                      onChanged: (p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(linkedIn: p0),
                              ),
                            );
                      },
                    ),
                    const CustomTextHeader(text: 'GITHUB'),
                    CustomTextField(
                      hint: 'ENTER YOUR PROFILE LINK',
                      onChanged: (p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(gitHub: p0),
                              ),
                            );
                      },
                    ),
                    const CustomTextHeader(text: 'WHATSAPP'),
                    CustomTextField(
                      hint: 'ENTER YOUR PHONE NUMBER',
                      onChanged: (p0) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(mobileNumber: p0),
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
                      currentStep: 6,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Theme.of(context).colorScheme.background,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(tabController: tabController, text: 'DONE'),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text("Something Went Wrong"));
        }
      },
    );
  }
}
