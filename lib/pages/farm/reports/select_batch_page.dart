import 'package:epoultry/pages/farm/reports/number_birds_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../widgets/gradient_widget.dart';

class SelectBatchPage extends StatefulWidget {
  const SelectBatchPage({Key? key}) : super(key: key);

  @override
  State<SelectBatchPage> createState() => _SelectBatchPageState();
}

class _SelectBatchPageState extends State<SelectBatchPage> {
  final List<bool> _selected = List.generate(5, (i) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.background,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: CustomSpacing.s2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select Batch",
                style: TextStyle(fontSize: 3.h),
              ),
            ),
            SizedBox(
              height: CustomSpacing.s1,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.3.w, color: CustomColors.secondary)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.3.w, color: CustomColors.secondary)),
                hintText: 'Search',
              ),
            ),
            SizedBox(
              height: CustomSpacing.s1,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => setState(
                            () => _selected[index] = !_selected[index]),
                        tileColor: _selected[index]
                            ? Palette.kPrimary[200]
                            : Palette.kPrimary[100],
                        title: Text("Batch ${index + 1}"),
                      );
                    })),
            GradientWidget(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NumberOfBirdsReportPage()),
                    );
                  },
                  child: Text('START REPORT'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      onPrimary: CustomColors.background,
                      fixedSize: Size(100.w, 6.h))),
            ),
            SizedBox(
              height: CustomSpacing.s1,
            ),
          ],
        ),
      ),
    );
  }
}
