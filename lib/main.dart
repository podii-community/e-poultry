import 'package:epoultry/data/queries.dart';
import 'package:epoultry/graphql/graphql_config.dart';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/landing_page.dart';
import 'package:epoultry/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
      return 'Bearer ${box.get("token")}';
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
    // Test if Location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the Location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the Location services.
        return Future.error('Location permissions are disabled.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are disabled permanently.');
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
            child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Epoultry',
                theme: CustomTheme.lightTheme,
                localizationsDelegates: const [
                  FormBuilderLocalizations.delegate,
                ],
                home: const LandingPage()
                // const BriquettesReceived(
                //   batchDetails: BatchModel(
                //       name: "Test",
                //       type: BirdTypes.BROILERS,
                //       birdAge: 20,
                //       birdCount: 200,
                //       ageType: AgeTypes.DAYS,
                //       date: "24/10/2022",
                //       farmId: ""),
                //   report: null,
                // )

                ),
          ),
        );
      },
    );
  }
}
