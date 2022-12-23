import 'package:epoultry/pages/extensions/requests_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../theme/spacing.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            const Text(
              'NEW REQUESTS',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  letterSpacing: 0.15000000596046448,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color.fromRGBO(246, 251, 255, 1),
              ),
              child: SingleChildScrollView(
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
                          color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
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
                      'Odongo odongo would like you to visit Teriq farm in Vihiga, sublocation, ward on Monday, 17th October 2022.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(1, 33, 56, 1),
                          fontFamily: 'DM Sans',
                          fontSize: 16,
                          letterSpacing: -0.23999999463558197,
                          fontWeight: FontWeight.normal,
                          height: 1.375),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Request by Odongo Odongo \n Teriq farm, Vihiga, sub, ward',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(1, 33, 56, 1),
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.6),
                        ),
                        IconButton(
                          icon: const Icon(PhosphorIcons.arrowCircleRightBold),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RequestsPage(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
