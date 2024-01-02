import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tuncjob/blocs/onboarding/onboarding_bloc.dart';
import 'package:tuncjob/screens/onboarding/widgets/widgets.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;

  const Pictures({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          var images = state.user.imageUrls;
          var imagesCount = images.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(text: 'Add 2 or More Pictures'),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return (imagesCount > index)
                              ? CustomImageContainer(
                                  imageUrl: images[index],
                                )
                              : const CustomImageContainer();
                        },
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 4,
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
            child: Text("Something Went Wrong"),
          );
        }
      },
    );
  }

  // Padding _picColumn2(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const CustomTextHeader(text: 'Add 2 or More Pictures'),
  //             const SizedBox(height: 20),
  //             // BlocBuilder<ImagesBloc, ImagesState>(
  //             //   builder: (context, state) {
  //             //     if (state is ImagesLoading) {
  //             //       return const Center(
  //             //         child: CircularProgressIndicator(),
  //             //       );
  //             //     }
  //             //     if (state is ImagesLoaded) {
  //             //       var imagesCount = state.imageUrls.length;
  //             //       return SizedBox(
  //             //         height: 350,
  //             //         child: GridView.builder(
  //             //           gridDelegate:
  //             //               const SliverGridDelegateWithFixedCrossAxisCount(
  //             //             crossAxisCount: 3,
  //             //             childAspectRatio: 0.66,
  //             //           ),
  //             //           itemCount: 6,
  //             //           itemBuilder: (context, index) {
  //             //             return (imagesCount > index)
  //             //                 ? CustomImageContainer(
  //             //                     imageUrl: state.imageUrls[index],
  //             //                   )
  //             //                 : const CustomImageContainer();
  //             //           },
  //             //         ),
  //             //       );
  //             //     } else {
  //             //       return const Center(
  //             //         child: Text("Something went wrong"),
  //             //       );
  //             //     }
  //             //   },
  //             // ),
  //           ],
  //         ),
  //         Column(
  //           children: [
  //             StepProgressIndicator(
  //               totalSteps: 6,
  //               currentStep: 4,
  //               selectedColor: Theme.of(context).primaryColor,
  //               unselectedColor: Theme.of(context).colorScheme.background,
  //             ),
  //             const SizedBox(height: 10),
  //             CustomButton(tabController: tabController, text: 'NEXT STEP'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // // ignore: unused_element
  // Column _picColumn(int imagesCount, ImagesLoaded state) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           imagesCount > 0
  //               ? CustomImageContainer(
  //                   imageUrl: state.imageUrls[0],
  //                 )
  //               : const CustomImageContainer(),
  //           imagesCount > 1
  //               ? CustomImageContainer(
  //                   imageUrl: state.imageUrls[1],
  //                 )
  //               : const CustomImageContainer(),
  //           imagesCount > 2
  //               ? CustomImageContainer(
  //                   imageUrl: state.imageUrls[2],
  //                 )
  //               : const CustomImageContainer(),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           imagesCount > 3
  //               ? CustomImageContainer(
  //                   imageUrl: state.imageUrls[3],
  //                 )
  //               : const CustomImageContainer(),
  //           imagesCount > 4
  //               ? CustomImageContainer(
  //                   imageUrl: state.imageUrls[4],
  //                 )
  //               : const CustomImageContainer(),
  //           imagesCount > 5
  //               ? CustomImageContainer(
  //                   imageUrl: state.imageUrls[5],
  //                 )
  //               : const CustomImageContainer(),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
