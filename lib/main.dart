import 'dart:developer';

import 'package:epoultry/data/queries.dart';
import 'package:epoultry/graphql/graphql-config.dart';
import 'package:epoultry/pages/farm/farm-managers/edit-profile_page.dart';
import 'package:epoultry/pages/farm/farm-managers/profile_page.dart';
import 'package:epoultry/pages/farm/quotation/request_quotation_page.dart';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:epoultry/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('appData');

  final box = Hive.box('appData');
  runApp(box.get('token') != null
      ? MyApp(page: 'dashboard')
      : MyApp(page: 'login'));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.page}) : super(key: key);

  String page;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  GraphQLConfiguration graphQLConfig = GraphQLConfiguration();
  HttpLink authentication = HttpLink(
    "https://cbsmartfarm.herokuapp.com/api/graphql/auth",
  );

  HttpLink authorised =
      HttpLink("https://cbsmartfarm.herokuapp.com/api/graphql");

  final box = Hive.box('appData');

  late AuthLink authLink = AuthLink(
    getToken: () async {
      return 'Bearer ' + box.get("token");
    },
  );

  late Link link = authLink.concat(authorised);

  Link getLink() {
    return Link.split((request) {
      return request.operation.operationName == 'RequestLoginOtp' ||
          request.operation.operationName == "VerifyOtp" ||
          request.operation.operationName == "RegisterUser";
    }, authentication, link);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    log("$serviceEnabled");
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: "Location services are disabled.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Location permissions are denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              "Location permissions are permanently denied, we cannot request permissions.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: getLink(),
      ),
    );
    return client;
  }

  final queries = EpoultryQueries();

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return QueriesDocumentProvider(
          queries: queries,
          child: GraphQLProvider(
            client: initializeClient(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Epoultry',
                theme: CustomTheme.lightTheme,
                home: const LandingPage()
                // home: widget.page == 'login' ? const LandingPage() : const FarmDashboardPage(),
                ),
          ),
        );
      },
    );
  }
}
