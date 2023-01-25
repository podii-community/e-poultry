import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farm_controller.dart';
import '../../theme/colors.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({Key? key, required this.extensionServiceId})
      : super(key: key);
  final extensionServiceId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmsController>();
    var filteredList = controller.requestsList
        .where((element) => element["id"] == extensionServiceId)
        .toList();

    String? farmName = controller.requestsList[0]["farm"]["name"];
    String? name = controller.requestsList[0]["farm"]["owner"]["firstName"]! +
        " " +
        controller.requestsList[0]["farm"]["owner"]["lastName"]!;
    String id = controller.requestsList[0]["id"];
    String? county = controller.requestsList[0]["farm"]["address"]["county"];
    String? subCounty =
        controller.requestsList[0]["farm"]["address"]["subcounty"];
    String? visitPorpose = "Medical Help";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        title: Text(
          farmName!,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "#$visitPorpose",
              style: TextStyle(
                fontSize: 18,
                color:
                    visitPorpose == "Medical Help" ? Colors.red : Colors.blue,
              ),
              // style: TextStyelsjn,
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempor \n incididunt ut labore et dolore magna aliqua. \n Libero id faucibus nisl tincidunt.',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const SizedBox(
              height: 18,
            ),
            Image.asset("assets/rectangle.png"),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Type of bird: ',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const Text(
              'Age of birds: 8 weeks ',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const Text(
              'No of birds: 500.',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              'Request by $name',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            Text(
              '$farmName, $county, $subCounty',
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 1),
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            // Text(
            //   '$formattedDate, $formattedTime',
            //   textAlign: TextAlign.left,
            //   style: const TextStyle(
            //       color: Color.fromRGBO(1, 33, 56, 1),
            //       fontFamily: 'Roboto',
            //       fontSize: 18,
            //       letterSpacing: 0.15000000596046448,
            //       fontWeight: FontWeight.normal,
            //       height: 1),
            // ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Accept'),
                    style: TextButton.styleFrom(
                      side: const BorderSide(width: 3.0, color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('Call'),
                    style: TextButton.styleFrom(
                      side: const BorderSide(width: 3.0, color: Colors.amber),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
