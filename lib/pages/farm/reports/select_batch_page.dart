import 'package:epoultry/pages/farm/reports/number_birds_page.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../models/batch_model.dart';
import '../../../services/batches_service.dart';
import '../../../services/sqlite_service.dart';
import '../../../theme/colors.dart';
import '../../../widgets/gradient_widget.dart';

class SelectBatchPage extends StatefulWidget {
  SelectBatchPage({Key? key}) : super(key: key);
  bool isSelected = false;
  @override
  State<SelectBatchPage> createState() => _SelectBatchPageState();
}

class _SelectBatchPageState extends State<SelectBatchPage> {
  final List<bool> _selected = List.generate(5, (i) => false);

  BatchesService _batchesService = BatchesService();

  List<Batches> _batches = [];
  List<Batches> _selectedBatch = [];

  late SqliteService _sqliteService;
  bool _isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sqliteService = SqliteService();
    _sqliteService.initializeDB().whenComplete(() async {
      await _getBatches();
      setState(() {});
    });
    _isSelected = widget.isSelected;
  }

  _getBatches() async {
    final data = await _batchesService.getItems();
    setState(() {
      _batches = data;
    });
  }

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
                    itemCount: _batches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (_selectedBatch.isEmpty) {
                            _selectedBatch.add(_batches[index]);
                          } else {
                            _selectedBatch[0] = _batches[index];
                          }

                          setState(() {
                            _isSelected = !_isSelected;
                          });
                        },
                        tileColor: _isSelected
                            ? Palette.kPrimary[200]
                            : Palette.kPrimary[100],
                        title: Text("${_batches[index].name}"),
                      );
                    })),
            GradientWidget(
              child: ElevatedButton(
                  onPressed: _selectedBatch.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NumberOfBirdsReportPage(
                                      batchDetails: _selectedBatch[0],
                                    )),
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
