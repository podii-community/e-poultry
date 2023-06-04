import 'package:epoultry/core/data/data_source/queries.dart';
import 'package:epoultry/core/data/data_source/graphql/graphql_config.dart';

import 'package:epoultry/core/data/data_source/graphql/query_document_provider.dart';
import 'package:epoultry/core/utils/core_constants.dart';
import 'package:epoultry/features/extensions/extension_homepage.dart';
import 'package:epoultry/features/farm/dashboard/presentation/farm_dashboard_page.dart';
import 'package:epoultry/features/auth/landing_page.dart';
import 'package:epoultry/features/veterinary/vet_homepage.dart';
import 'package:epoultry/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

import 'core/presentation/controllers/farm_controller.dart';
import 'core/presentation/controllers/user_controller.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('appData');
  final box = Hive.box('appData');
  runApp(const Epoultry());
}

class Epoultry extends StatefulWidget {
  const Epoultry({
    Key? key,
  }) : super(key: key);

  @override
  State<Epoultry> createState() => _EpoultryState();
}

class _EpoultryState extends State<Epoultry> {
  GraphQLConfiguration graphQLConfig = GraphQLConfiguration();

  HttpLink authentication = HttpLink(
    CoreConstants.authHttpLink,
  );

  HttpLink authorised = HttpLink(CoreConstants.authorisedHttpLink);

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
          request.operation.operationName == "RegisterExtensionOfficer" ||
          request.operation.operationName == "RegisterVetOfficer" ||
          request.operation.operationName == "RegisterUser";
    }, authentication, link);
  }

  ValueNotifier<GraphQLClient> initializeClient() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        defaultPolicies: DefaultPolicies(
          // make watched mutations behave like watched queries.
          watchMutation: Policies(
            fetch: FetchPolicy.networkOnly,
            error: ErrorPolicy.none,
            cacheReread: CacheRereadPolicy.mergeOptimistic,
          ),
          watchQuery: Policies(
            fetch: FetchPolicy.networkOnly,
            error: ErrorPolicy.none,
            cacheReread: CacheRereadPolicy.mergeOptimistic,
          ),
        ),
        cache: GraphQLCache(),
        link: getLink(),
      ),
    );
    return client;
  }

  final queries = EpoultryQueries();

  late final token = box.get("token");
  late final role = box.get("tokenRole");

  // print(role);
  final FarmsController controller =
      Get.put(FarmsController(), permanent: true);
  final UserController userController =
      Get.put(UserController(), permanent: true);

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
                home: checkAuth(token, role)),
          ),
        );
      },
    );
  }

  Widget checkAuth(token, role) {
    if (token?.toString().isNotEmpty != true) {
      return const LandingPage();
    }

    switch (role) {
      case "FARMER":
        return const FarmDashboardPage();
      case "FARM_MANAGER":
        return const FarmDashboardPage();
      case "VET_OFFICER":
        return const VeterinaryHomePage();
      case "EXTENSION_OFFICER":
        return const ExtensionHomePage();

      default:
        return const LandingPage();
    }
  }
}
