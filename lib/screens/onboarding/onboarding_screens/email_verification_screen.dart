import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuncjob/screens/onboarding/widgets/widgets.dart';

class EmailVerification extends StatelessWidget {
  final TabController tabController;

  EmailVerification({
    Key? key,
    required this.tabController,
  }) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              const CustomTextHeader(
                  text: 'Did You Get the Verification Code?'),
              CustomTextField(
                hint: 'ENTER YOUR CODE',
                textEditingController: textEditingController,
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(height: 10),
              CustomButton(tabController: tabController, text: 'NEXT STEP'),
            ],
          ),
        ],
      ),
    );
  }
}
