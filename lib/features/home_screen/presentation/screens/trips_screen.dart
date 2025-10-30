import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reckit/core/constants/colors.dart';
import 'package:reckit/core/utils/gridview_extension.dart';
import 'package:reckit/core/widgets/default_button.dart';
import 'package:reckit/features/home_screen/presentation/widgets/wide_app_bar.dart';

import '../../../../core/constants/text_styles.dart';
import '../provider/home_provider.dart';
import '../widgets/trips_card.dart';

class TripsScreen extends ConsumerStatefulWidget {
  const TripsScreen({super.key});

  @override
  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen> {
  List<String> taps = ['Items', 'Pricing', 'Info', 'Tasks', 'Analytics'];
  String currentTap = 'Items';
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(tripsNotifierProvider.notifier).loadTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tripsNotifierProvider);
    print(1.sw);
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              WideAppBar(
                onSelectTap: (tap) {
                  setState(() {
                    currentTap = tap;
                  });
                },
                taps: taps,
                currentTap: currentTap,
              ),
              Container(width: 1.sw, height: 0.2, color: AppColors.hintColor),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            currentTap,
                            style: TextStyles.textStyle32Regular,
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.blackCard,
                            ),
                            child: Icon(Icons.tune_outlined, size: 20),
                          ),
                          10.horizontalSpace,
                          Container(
                            height: 50,
                            width: 1,
                            color: AppColors.blackCard,
                          ),
                          10.horizontalSpace,
                          MainButtonWidget(
                            label: 'Add a New Item',
                            buttonColor: AppColors.primaryColor,
                            style: TextStyles.textStyle14Medium.copyWith(
                              color: AppColors.black,
                            ),
                            borderRadius: 50,
                            width: 150,
                            height: 45,
                            rightIcon: Icon(Icons.add, color: AppColors.black),
                          ),
                        ],
                      ),

                      20.verticalSpace,
                      state.loading
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1.sw.itemCount,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 1.sw.childAspectRatio,
                                  ),
                              itemCount: state.trips.length,
                              itemBuilder: (context, idx) {
                                final trip = state.trips[idx];
                                return TripCard(trip: trip);
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
