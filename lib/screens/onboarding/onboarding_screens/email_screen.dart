import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuncjob/cubits/sign_up/signup_cubit.dart';
import 'package:tuncjob/screens/onboarding/widgets/widgets.dart';

class Email extends StatelessWidget {
  final TabController tabController;
  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  const CustomTextHeader(text: 'What\'s Your Email Address?'),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChanged: (p0) {
                      context.read<SignupCubit>().emailChanged(p0);
                      log("Email Changed:${state.email}");
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const CustomTextHeader(text: 'Choose A Password'),
                  CustomTextField(
                    hint: 'ENTER YOUR PASSWORD',
                    onChanged: (p0) {
                      context.read<SignupCubit>().passwordChanged(p0);
                      log("Password Changed:${state.password}");
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    tabController: tabController,
                    text: 'NEXT STEP',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
