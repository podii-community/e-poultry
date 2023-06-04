import 'package:epoultry/core/data/data_export.dart';
import 'package:epoultry/core/presentation/components/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'loading_spinner.dart';

class QueryWrapper<T> extends StatelessWidget {
  const QueryWrapper({
    Key? key,
    required this.queryString,
    required this.contentBuilder,
    required this.dataParser,
    this.variables,
  }) : super(key: key);

  final Map<String, dynamic>? variables;
  final String queryString;
  final Widget Function<T>(T data) contentBuilder;
  final T Function(Map<String, dynamic> data) dataParser;
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(queryString),
        variables: variables ?? const {},
        parserFn: dataParser,
      ),
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

        // return contentBuilder(result.parserFn());
        return contentBuilder((result.parserFn(result.data ?? const {})));
      },
    );
  }
}
