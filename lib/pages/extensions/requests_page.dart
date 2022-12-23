import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../widgets/gradient_widget.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        title: const Text(
          "Request 001",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              '#MEDICAL HELP',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
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
              'Type of bird: Layers  \n Age of birds: 8 weeks \n No of birds: 500.',
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
            const Text(
              'Request by Odongo Odongo  \n Teriq farm, Vihiga, sub, ward \n 17th November 2022, 4:00pm.',
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
