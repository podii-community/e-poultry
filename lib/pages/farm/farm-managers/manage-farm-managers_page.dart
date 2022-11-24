import 'package:epoultry/controllers/managers_controller.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/pages/farm/farm-managers/add-farm-manager_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';

class ManageFarmManagers extends StatefulWidget {
  const ManageFarmManagers({Key? key}) : super(key: key);

  @override
  State<ManageFarmManagers> createState() => _ManageFarmManagersState();
}

class _ManageFarmManagersState extends State<ManageFarmManagers> {
  final ManagersController managersController = ManagersController();
  final FarmsController farmsController = Get.put(FarmsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.background,
        centerTitle: true,
        elevation: 0,
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
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: CustomSpacing.s2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Manage Farm Managers",
                style: TextStyle(fontSize: 3.h),
              ),
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            GradientWidget(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddFarmManagerPage()),
                  );
                },
                leading: const Icon(
                  PhosphorIcons.plusCircleFill,
                  color: CustomColors.background,
                ),
                title: Text(
                  "Add a farm manager",
                  style: TextStyle(fontSize: 2.3.h),
                ),
                tileColor: Colors.transparent,
                textColor: CustomColors.background,
              ),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ALL FARM MANAGERS",
                style: TextStyle(fontSize: 2.2.h),
              ),
            ),
            Expanded(
              child: Query(
                options: QueryOptions(
                    document: gql(context.queries.getFarmManagers()),
                    fetchPolicy: FetchPolicy.noCache,
                    pollInterval: const Duration(minutes: 2),
                    variables: {"farmId": farmsController.farm.value['id']}),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.isLoading) {
                    return const LoadingSpinner();
                  }
                  if (result.hasException) {
                    return AppErrorWidget(
                      error: ErrorModel.fromString(
                        result.exception.toString(),
                      ),
                    );
                  }

                  List farmManagers = result.data?["farmManagers"];

                  managersController.managers(farmManagers);

                  // return Container();

                  return managersController.managers.isEmpty
                      ? const Center(
                          child: Text("No Farm Managers"),
                        )
                      : ListView.builder(
                          itemCount: managersController.managers.length,
                          itemBuilder: (context, position) {
                            return Card(
                                elevation: 0.2,
                                child: ListTile(
                                  selectedColor: CustomColors.secondary,
                                  title: Text(
                                      "${managersController.managers[position]["firstName"]}"),
                                  trailing: SizedBox(
                                    width: 30.w,
                                    child: Mutation(
                                      options: MutationOptions(
                                        operationName: "RemoveFarmManager",
                                        document: gql(context.queries
                                            .removeFarmManager()),
                                        onCompleted: (data) =>
                                            _onCompleted(data, context),
                                      ),
                                      builder: (RunMutation runMutation,
                                          QueryResult? result) {
                                        if (result != null) {
                                          if (result.isLoading) {
                                            return const LoadingSpinner();
                                          }

                                          if (result.hasException) {
                                            context.showError(
                                              ErrorModel.fromGraphError(
                                                result.exception
                                                        ?.graphqlErrors ??
                                                    [],
                                              ),
                                            );
                                          }
                                        }

                                        return IconButton(
                                            onPressed: () {
                                              // Show confirmaion dialog
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Remove Manager"),
                                                      content: const Text(
                                                          "Are you sure you want to remove this manager?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Cancel")),
                                                        TextButton(
                                                            onPressed: () {
                                                              var payload = {
                                                                "farmId": managersController
                                                                            .managers[
                                                                        position]
                                                                    [
                                                                    "managingFarms"][0]["id"],
                                                                "farmManagerId":
                                                                    managersController
                                                                            .managers[
                                                                        position]["id"]
                                                              };
                                                              _removeManagerButtonPressed(
                                                                  context,
                                                                  runMutation,
                                                                  payload);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Remove"))
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: const Icon(
                                              PhosphorIcons.trash,
                                              color: CustomColors.red,
                                            ));
                                      },
                                    ),
                                  ),
                                ));
                          });
                },
              ),
            ),
          ])),
    );
  }

  void _onCompleted(data, BuildContext context) {
    // / If they do, move to home page. If not, take them to select artist page for them to select artists.
    if (data["removeFarmManager"]) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessWidget(
                    message: 'Farm manager was deleted',
                    route: 'manager',
                  )));
    }
  }

  Future<void> _removeManagerButtonPressed(
      BuildContext context, RunMutation runMutation, payload) async {
    runMutation(
      {'farmId': payload["farmId"], "farmManagerId": payload["farmManagerId"]},
    );
  }
}
