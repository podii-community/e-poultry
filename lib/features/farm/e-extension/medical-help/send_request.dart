import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:epoultry/features/farm/dashboard/presentation/components/batch_page/create_batch_page.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/presentation/controllers/farm_controller.dart';
import '../../../../theme/colors.dart';
import '../../../../core/presentation/components/gradient_widget.dart';
import '../../../../core/presentation/components/loading_spinner.dart';
import '../../../../core/presentation/components/success_widget.dart';

class GetMedicalHelp extends StatefulWidget {
  const GetMedicalHelp({super.key});

  @override
  State<GetMedicalHelp> createState() => _GetMedicalHelpState();
}

class _GetMedicalHelpState extends State<GetMedicalHelp> {
  final controller = Get.find<FarmsController>();

  final selectedBatch = TextEditingController();

  final issue = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FilePickerResult? file;
  PlatformFile? pickedFile;
  List<PlatformFile> pickedFiles = [];
  bool agree = false;
  bool uploaded = false;
  bool loading = false;

  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    if (controller.batchesList.isNotEmpty) {
      selectedBatch.text = controller.batchesList.first['id'];
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Get Medical Help',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: controller.batchesList.isEmpty
          ? Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text('You dont have any batches.Create one'),
                    TextButton(
                        onPressed: (() => Get.to(const CreateBatchPage())),
                        child: const Text('Create Batch'))
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Text(
                    "Select the batch you want to vaccinate",
                    style: TextStyle(fontSize: 2.2.h),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  DropdownButtonFormField<dynamic>(
                    // Initial Value
                    key: UniqueKey(),
                    value: selectedBatch.text,
                    isExpanded: true,
                    elevation: 0,
                    decoration: InputDecoration(
                        hintText: "Select batch",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        helperText:
                            "Selecting a batch will share the type of birds, age and number of birds. This will help the vet better advise on the doses required for medication",
                        helperMaxLines: 5,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),

                    onChanged: (val) {},
                    items: controller.batchesList.map((batch) {
                      return DropdownMenuItem<dynamic>(
                        value: batch['id'],
                        child: Text(batch['name']),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    controller: issue,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'What issue are you facing?';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Describe the issue",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  pickedFiles.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              children: List.generate(
                                  pickedFiles.length,
                                  (index) => Container(
                                        margin: const EdgeInsets.only(right: 30),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                              height: 30.h,
                                              width: pickedFiles.length == 1
                                                  ? 90.w
                                                  : 70.w,
                                              decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .drawerBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          pickedFiles[index]
                                                              .path!)),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Positioned(
                                              right: -20,
                                              top: -15,
                                              child: GestureDetector(
                                                onTap: () {
                                                  deleteImageAtIndex(index);
                                                  if (pickedFiles.isEmpty) {
                                                    resetImage();
                                                  }
                                                  // pickedFiles.removeAt(index);
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 4),
                                                      color: Colors.white,
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              "assets/cancel.png"))),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 100.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Click the button below to upload image",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  DottedBorder(
                    color: CustomColors.secondary,
                    child: uploaded
                        ? Container(
                            height: 20.h,
                            width: 100.w,
                            color: CustomColors.drawerBackground,
                            child: const Center(child: Text('File Uploaded')))
                        : InkWell(
                            onTap: () => pickFiles(),
                            child: Container(
                                height: 20.h,
                                width: 100.w,
                                color: CustomColors.drawerBackground,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      PhosphorIcons.plusCircleFill,
                                      color: CustomColors.secondary,
                                      size: 10.h,
                                    ),
                                    const SizedBox(
                                      height: CustomSpacing.s1,
                                    ),
                                    const Text("Upload an image")
                                  ],
                                )),
                          ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  CheckboxListTile(
                    title: const Text(
                        "I understand that this service may accrue a charge that will be agreed upon by both the officer and I"),
                    value: agree,
                    onChanged: (newValue) {
                      setState(() {
                        agree = newValue!;
                      });
                    },
                    subtitle: agree
                        ? null
                        : const Text(
                            "Agree to terms and conditions",
                            style: TextStyle(color: Colors.red),
                          ),
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  loading
                      ? const LoadingSpinner()
                      : GradientWidget(
                          child: ElevatedButton(
                            onPressed: () {
                              // if (_formKey.currentState!.validate()) {
                              //   submit();
                              // }
                              submit();
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: CustomColors.background,
                                backgroundColor: Colors.transparent,
                                disabledForegroundColor:
                                    Colors.transparent.withOpacity(0.38),
                                disabledBackgroundColor:
                                    Colors.transparent.withOpacity(0.12),
                                shadowColor: Colors.transparent,
                                fixedSize: Size(100.w, 6.h)),
                            child: Text(
                              'REQUEST',
                              style: TextStyle(
                                fontSize: 1.8.h,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                ],
              ),
            )),
    );
  }

  // Future<void> _onCompleted(data, BuildContext context) async {
  //   if ((data['requestMedicalVisit']['farmId']).toString().isNotEmpty) {
  //     Get.to(() => const SuccessWidget(
  //           message:
  //               'You have sucessfully requested for medical help. We’ll notify you as soon as there is a Vetinary officer available.',
  //           route: 'dashboard',
  //         ));
  //   }
  // }

  // Future<void> _requestMedicalVisitPressed(
  //     BuildContext context, RunMutation runMutation) async {
  //   runMutation({
  //     "data": {'batchId': selectedBatch.text, "description": issue.text},
  //   });
  // }

  pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: true);

    if (result != null) {
      pickedFiles = result.files
          .map((file) =>
              PlatformFile(name: file.name, size: file.size, path: file.path))
          .toList();
    } else {
      resetImage();
      return;
    }
    setState(() {
      uploaded = true;
    });

    // if (result != null) {
    //   file = result;
    //   pickedFile = result.files.first;
    // } else {
    //   resetImage();
    // }
  }

  resetImage() {
    setState(() {
      uploaded = false;
      // file = null;
      pickedFiles = [];
      // pickedFile = null;
    });
  }

  deleteImageAtIndex(int index) {
    setState(() {
      pickedFiles.removeAt(index);
      pickedFiles;
    });
  }

  submit() async {
    setState(() {
      loading = true;
    });

    // final formData = FormData.fromMap({
    //   'batchId': selectedBatch.text,
    //   'description': issue.text,
    //   'attachments[0]':await MultipartFile.fromFile(file!.files.first.path!,
    //       filename: file!.files.first.name),
    // });

    final formData = FormData();
    formData.fields.addAll([
      MapEntry('batchId', selectedBatch.text),
      MapEntry('description', issue.text)
    ]);

    for (int i = 0; i < pickedFiles.length; i++) {
      final file = pickedFiles[i];
      formData.files.add(MapEntry(
        'attachments[$i]',
        await MultipartFile.fromFile(file.path!, filename: file.name),
      ));
    }

    final box = Hive.box('appData');

    final response = await dio.post(
      'https://cbsmartfarm.herokuapp.com/api/extension_services/medical_visit',
      data: formData,
      options: Options(
        headers: {
          "authorization": "Bearer ${box.get("token")}",
        },
      ),
      onSendProgress: (int sent, int total) {
        if (sent == total) {
          setState(() {
            uploaded = true;
          });
        }
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      Get.to(() => const SuccessWidget(
            message:
                'You have sucessfully requested for medical help. We’ll notify you as soon as there is a Vetinary officer available.',
            route: 'dashboard',
          ));
    }
  }
}
