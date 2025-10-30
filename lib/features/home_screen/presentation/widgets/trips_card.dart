import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reckit/core/constants/colors.dart';
import 'package:reckit/core/constants/text_styles.dart';
import 'package:reckit/core/enum/trip_status.dart';
import 'package:reckit/core/utils/app_utils.dart';
import 'package:reckit/core/widgets/cached_network_image.dart';
import 'package:reckit/gen/assets.gen.dart';
import '../../data/models/trip_model.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  const TripCard({Key? key, required this.trip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TripStatus status = trip.status.tripStatus;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImageHelper(
              imageUrl: trip.coverImage,
              fit: BoxFit.fill,
              height: 210,
              width: double.infinity,
              borderRadius: 0,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.05, 0.1, 0.3],
                  colors: [
                    AppColors.blackCard.withOpacity(0.02),
                    AppColors.blackCard.withOpacity(0.05),
                    AppColors.blackCard.withOpacity(0.1),
                    AppColors.blackCard,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: status.tripStatusColor.withOpacity(0.1),
                      border: Border.all(color: status.tripStatusColor),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      trip.status,
                      style: TextStyles.textStyle14Regular,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    trip.title,
                    style: TextStyles.textStyle18Regular,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.images.calendar),
                      const SizedBox(width: 6),
                      Text(
                        AppUtils.formatDateRange('${trip.start} - ${trip.end}'),
                        style: TextStyles.textStyle12Regular.copyWith(
                          color: AppColors.hintColor,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.hintColor,
                    thickness: 0.1,
                    height: 20,
                  ),

                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // avatar stack
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: Stack(
                          children: List.generate(
                            trip.participants.length > 4
                                ? 4
                                : trip.participants.length,
                            (i) {
                              final p = trip.participants[i];
                              return Positioned(
                                left: i * 14.0,
                                height: 30,
                                child:
                                    trip.participants.length <= 4 ||
                                        (trip.participants.length > 4 && i < 3)
                                    ? ClipOval(
                                        child: CachedNetworkImageHelper(
                                          imageUrl: p.avatarUrl,
                                          height: 30,
                                          width: 30,
                                        ),
                                      )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.blackBackground,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+${trip.participants.length - 3}',
                                            style: TextStyles.textStyle12Regular
                                                .copyWith(
                                                  color: AppColors.primaryColor,
                                                ),
                                          ),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),

                      // unfinished tasks
                      Text(
                        '${trip.unfinishedTasks} unfinished tasks',
                        style: TextStyles.textStyle12Regular.copyWith(
                          color: AppColors.hintColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.black.withOpacity(0.6),
              child: Icon(Icons.more_horiz, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
