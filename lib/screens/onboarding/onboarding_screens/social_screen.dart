// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
                textEditingController: textEditingController,
              ),
              const CustomTextHeader(text: 'GITHUB'),
              CustomTextField(
                hint: 'ENTER YOUR PROFILE LINK',
                textEditingController: textEditingController2,
              ),
              const CustomTextHeader(text: 'WHATSAPP'),
              CustomTextField(
                hint: 'ENTER YOUR PHONE NUMBER',
                textEditingController: textEditingController3,
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
  }
}
