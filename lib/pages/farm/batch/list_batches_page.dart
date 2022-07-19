import 'package:epoultry/pages/farm/batch/create_batch_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class ListBatchPage extends StatelessWidget {
  const ListBatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: CustomSpacing.s2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Manage Batches",
              style: TextStyle(fontSize: 3.h),
            ),
          ),
          SizedBox(
            height: CustomSpacing.s1,
          ),
          GradientWidget(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateBatchPage()),
                );
              },
              leading: const Icon(
                PhosphorIcons.plusCircleFill,
                color: CustomColors.background,
              ),
              title: Text(
                "Add a new batch",
                style: TextStyle(fontSize: 2.3.h),
              ),
              tileColor: Colors.transparent,
              textColor: CustomColors.background,
            ),
          ),
          SizedBox(
            height: CustomSpacing.s2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "My Batches",
              style: TextStyle(fontSize: 2.2.h),
            ),
          ),
          SizedBox(
            height: CustomSpacing.s1,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, position) {
                  return Card(
                    elevation: 0.2,
                    child: ListTile(
                      title: Text("Batch ${position + 1}"),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
