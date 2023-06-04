import 'package:epoultry/core/data/data_source/queries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../data_export.dart';

class QueriesDocumentProvider extends InheritedWidget {
  const QueriesDocumentProvider(
      {Key? key, required this.queries, required Widget child})
      : super(key: key, child: child);

  final EpoultryQueries queries;

  static EpoultryQueries of(BuildContext context) {
    final InheritedElement? element = context
        .getElementForInheritedWidgetOfExactType<QueriesDocumentProvider>();
    assert(element != null, 'No EpoultryQueries found in context');
    return (element!.widget as QueriesDocumentProvider).queries;
  }

  @override
  bool updateShouldNotify(QueriesDocumentProvider oldWidget) =>
      queries != oldWidget.queries;
}

extension BuildContextExtension on BuildContext {
  EpoultryQueries get queries => QueriesDocumentProvider.of(this);

  GraphQLClient get graphQlClient => GraphQLProvider.of(this).value;

  void cacheToken(String token) {
    graphQlClient.cache.writeNormalized('AppData', {'token': token});
  }

  /// Retrieves current user's Token from the cache
  String get retrieveToken =>
      graphQlClient.cache.store.get('AppData')!['token'];

  // void showError(ErrorModel error) {
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     final scaffold = Scaffold.of(this);
  //     Scaffold.of(this).showSnackBar(
  //       SnackBar(
  //         content: Text(error.error),
  //         backgroundColor: Colors.red,
  //         duration: const Duration(seconds: 5),
  //       ),
  //     );
  //   });
  // }

  void showError(ErrorModel error) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Fluttertoast.showToast(
          msg: error.error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(this).showMaterialBanner(
      //   MaterialBanner(
      // backgroundColor: theme.colorScheme.primary,
      // contentTextStyle:
      //     theme.textTheme.headline5!.copyWith(color: Colors.white),
      //     content: Text(error.error),
      //     actions: [
      //       InkWell(
      //         onTap: () => ScaffoldMessenger.of(this).clearMaterialBanners(),
      //         child: const Icon(Icons.close, color: Colors.white),
      //       )
      //     ],
      //   ),
      // );
    });
  }
}
