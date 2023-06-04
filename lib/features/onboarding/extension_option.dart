import 'package:epoultry/features/onboarding/reg_forms/extension_officer.dart';
import 'package:epoultry/features/onboarding/reg_forms/veterinary_officer.dart';
// import 'package:epoultry/pages/onboarding/reg_forms/farmer.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';

import '../auth/registration.dart';

class ChooseExtension extends StatefulWidget {
  const ChooseExtension({super.key});

  @override
  State<ChooseExtension> createState() => _ChooseExtensionState();
}

class _ChooseExtensionState extends State<ChooseExtension> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png')),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Help us serve you better",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "What brings you to the app?",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        const Icon(
                          Icons.person,
                          color: CustomColors.primary,
                          size: 30,
                          // color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                          child: Text(
                            'I\'m a farmer manager looking to join an existing farm',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrationPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        const Icon(
                          Icons.person_outline,
                          color: CustomColors.primary,
                          size: 30,
                          // color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                          child: Text(
                            'I\'m a farmer looking to manage or start my own farm',
                            style: TextStyle(fontSize: 18),

                            // style: TextStyle(ccolor: Colors.white),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExtensionOfficer()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        const Icon(
                          Icons.people,
                          color: CustomColors.primary,
                          size: 30,
                          // color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                          child: Text(
                            'I\'m an E-Extension officer looking to offer services to farmers',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VeterinaryOfficer()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        const Icon(
                          Icons.people,
                          color: CustomColors.primary,
                          size: 30,
                          // color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                          child: Text(
                            'I\'m a Veterinary officer looking to offer services to farmers',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
