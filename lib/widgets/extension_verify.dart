import 'package:flutter/material.dart';

class ExtensionVerify extends StatelessWidget {
  const ExtensionVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Color.fromRGBO(1, 33, 56, 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                              width: 88,
                              height: 88,
                              child: Container(
                                  width: 88,
                                  height: 88,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      width: 2,
                                    ),
                                    image: const DecorationImage(
                                        image: AssetImage('assets/logo.png'),
                                        fit: BoxFit.fitWidth),
                                    borderRadius: const BorderRadius.all(
                                        Radius.elliptical(88, 88)),
                                  ))),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text(
                              'Margaret WN.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Extension officer',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '0701 234 567',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(246, 251, 255, 1),
                                  fontFamily: 'DM Sans',
                                  fontSize: 16,
                                  letterSpacing: 0.15000000596046448,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'ACCOUNT',
                  style: TextStyle(
                      color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      letterSpacing: 0.15000000596046448,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Divider(),
                Text(
                    "We are reviewing your account details.\n We’ll notify you as soon as it has been\n approved, till then you might not be able\n to acces some features.")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
