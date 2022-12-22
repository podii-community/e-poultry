import 'package:flutter/material.dart';

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
            const Text(
              'REQUESTS',
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
              height: 131,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color.fromRGBO(246, 251, 255, 1),
              ),
              child: const Center(
                child: Text(
                  'All your service requests will appear here',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(1, 33, 56, 0.3799999952316284),
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      letterSpacing: -0.23999999463558197,
                      fontWeight: FontWeight.normal,
                      height: 1.375),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
