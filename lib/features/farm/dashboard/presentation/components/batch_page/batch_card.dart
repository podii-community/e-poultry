import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BatchCard extends StatelessWidget {
  final String batchName;
  final int batchBirdCount;
  final int birdAge;
  final String birdAgeType;

  const BatchCard(
      {super.key,
      required this.batchName,
      required this.batchBirdCount,
      required this.birdAge,
      required this.birdAgeType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    batchName,
                    style: TextStyle(fontSize: 2.2.h),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        "$batchBirdCount Layers",
                        style: TextStyle(fontSize: 1.8.h),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        "$birdAge ${birdAgeType.toLowerCase().capitalizeFirst} old",
                        style: TextStyle(fontSize: 1.8.h),
                      ),
                    ],
                  )
                ],
              ),
            ),

            //  edit icon
            FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(CustomColors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.black)),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_rounded,
                      color: CustomColors.yellow,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(fontSize: 2.2.h),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
