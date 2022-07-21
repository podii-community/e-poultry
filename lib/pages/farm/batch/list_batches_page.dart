import 'dart:developer';

import 'package:epoultry/pages/farm/batch/create_batch_page.dart';
import 'package:epoultry/services/batches_service.dart';
import 'package:epoultry/services/sqlite_service.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../models/batch_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class ListBatchPage extends StatefulWidget {
  ListBatchPage({Key? key}) : super(key: key);

  @override
  State<ListBatchPage> createState() => _ListBatchPageState();
}

class _ListBatchPageState extends State<ListBatchPage> {
  BatchesService _batchesService = BatchesService();

  List<Batches> _batches = [];
  late SqliteService _sqliteService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sqliteService = SqliteService();
    _sqliteService.initializeDB().whenComplete(() async {
      await _getBatches();
      setState(() {});
    });
  }

  _getBatches() async {
    final data = await _batchesService.getItems();
    log("$data");
    setState(() {
      _batches = data;
    });
  }

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
            child: _batches.isEmpty
                ? Center(
                    child: Text('No batches'),
                  )
                : ListView.builder(
                    itemCount: _batches.length,
                    itemBuilder: (context, position) {
                      return Card(
                        elevation: 0.2,
                        child: ListTile(
                          title: Text("${_batches[position].name}"),
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
